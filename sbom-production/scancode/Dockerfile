FROM amd64/debian:bullseye-slim
RUN apt-get update && apt-get install -y git curl libicu-dev python3 python3-pip

RUN pip install --upgrade pip setuptools wheel
RUN pip install scancode-toolkit
CMD scancode --help