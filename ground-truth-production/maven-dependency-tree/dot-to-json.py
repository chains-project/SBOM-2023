#!/usr/bin/python3

import re
import sys
import json

def main(input_dot, output_json):
    with open(input_dot) as f:
        lines = f.readlines()
    
    indices = [i for i, x in enumerate(lines) if 'digraph' in x]

    all_modules_dependencies = []

    for digraph_start in indices:
        dependencies =  _iterate_digraph(digraph_start, lines)
        all_modules_dependencies.extend(dependencies)
    
    with open(output_json, 'w') as f:
        json.dump(all_modules_dependencies, f, indent=2)

def _iterate_digraph(index, lines):

    dependencies = []
    submodule = re.search('(?<=").*(?=")', lines[index]).group(0)

    # root_submodule = _parse_submodule_syntax(submodule)
    
    for i in range(index + 1, len(lines)):
        if '}' in lines[i]:
            break
        
        first_dependency, second_dependency = _parse_edge(lines[i])

        if first_dependency['scope'] == 'root_scope':
            # Depth = 1 is direct dependency
            dependencies.append({ **second_dependency, "depth": 1, "submodule": submodule})
        
        else:
            depth = _compute_depth(first_dependency, dependencies)
            dependencies.append({ **second_dependency, "depth": depth, "submodule": submodule })
    
    return dependencies


def _parse_submodule_syntax(submodule):
    components = submodule.split(':')
    # "org.asynchttpclient:async-http-client-project:pom:3.0.0.Beta1" -> "io.netty:netty-buffer:jar:4.1.87.Final:compile" ;
    if len(components) == 4:
        return {
        "groupId": components[0], # Group ID
        "artifactId" : components[1], # Artifact ID
        "classifier" : components[2], # Classifier
        "version" : components[3], # Version
        "scope" : 'root_scope' # Scope
        }
    elif len(components) == 5:
        return {
        "groupId": components[0], # Group ID
        "artifactId" : components[1], # Artifact ID
        "classifier" : components[2], # Classifier
        "version" : components[3], # Version
        "scope" : components[4] # Scope
        }
    elif len(components) == 6:
        return {
        "groupId": components[0], # Group ID
        "artifactId" : components[1], # Artifact ID

        "classifier" : components[2], # Classifier
        "version" : components[4], # Version
        "scope" : components[5] # Scope
        }

    raise Exception(f"Invalid submodule syntax {len(components)}: {submodule})")


def _parse_edge(line):
    regex = '(?<=\").*(?=\")'
    edge = re.search(regex, line).group(0)
    
    first_dependency, second_dependency = edge.split(' -> ')
    first_dependency = first_dependency.removesuffix('"')
    second_dependency = second_dependency.removeprefix('"')

    return _parse_submodule_syntax(first_dependency), _parse_submodule_syntax(second_dependency)  

def _compute_depth(first_dependency, dependencies):
    for dependency in dependencies:
        if dependency['groupId'] == first_dependency['groupId'] and dependency['artifactId'] == first_dependency['artifactId']:
            return dependency['depth'] + 1

if __name__ == '__main__':
    # Takes only 2 inputs. The path to dot file and output JSON file
    main(sys.argv[1], sys.argv[2])
