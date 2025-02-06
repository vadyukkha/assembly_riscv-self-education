FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade && apt-get install -y \
    libglib2.0-0 libglib2.0-dev \
    build-essential \
    cmake \
    bash \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /riscv64_asm_dev

COPY . /riscv64_asm_dev

CMD ["bash", "-c", "source /riscv64_asm_dev/sc-dt/env.sh && bash"]
