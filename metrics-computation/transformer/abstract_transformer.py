import json

class AbstractTransformer:
    def get_json_as_dict(self, input_file) -> dict:
        with open(input_file) as f:
            # Skip empty SBOMs
            contents = f.read()
            if contents == '':
                return None
            return json.loads(contents)
    
    def write(self, json_dict, output_file) -> None:
        if output_file is None:
            print(json.dumps(json_dict, indent=2))
        else:
            with open(output_file, 'w') as f:
                f.write(json.dumps(json_dict, indent=2))
