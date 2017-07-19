mincore
==

compsys2017の最終課題向けのコア，テスト，8パズルソルバーがあります．


## 概略
コアはrv32iのだいたいの命令を使うことができます．
したがって，[riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain) を用いてC言語のプログラムを実行できます．

テストは [riscv-tests](https://github.com/riscv/riscv-tests) が移植されており，`./test/test_op` にコードがあります．

8パズルソルバーに関しては，現在IDA*ベースのものが含まれています．
`./test/test_8puzzle` にコードがあります．


## コアのビルド
シミュレーションには [verilator](https://www.veripool.org/wiki/verilator) を使用します．
verilator にパスが通った状態でこのディレクトリで `make` することで，`./build` 以下にテストベンチがビルドされます．


## riscv-gnu-toolchain を使用するための設定
[riscv-gnu-toolchain](https://github.com/riscv/riscv-gnu-toolchain) をビルドします．
ビルド手順については公式のドキュメントに従ってください．
(`./configure --with-arch=rv32i --enable-multilib --prefix=<インストール先> && make -j` でだいたい上手くいくと思います)

このディレクトリで，`./configure RV32_GCC=<riscv-gnu-toolchainのgccへのパス> RV32_OBJCOPY=<riscv-gnu-toolchainのobjcopyへのパス>` とすることで，config.mak という設定ファイルが作られます．
コアのテスト，パズルソルバーのビルドを行う場合にはこの設定が必要になります．


## コアのテスト
(先にriscv-gnu-toolchain を使用するための設定を行なってください)
`./test/test_op`で `make` することで，`./test/test_op/build/memory.memh` が作られます．
`./test/test_op`で `make test` することで，コアのテストを行うことができます．


## ソルバーの実行
(先にriscv-gnu-toolchain を使用するための設定を行なってください)
`./test/test_8puzzle`で `make` することで，`./test/test_8puzzle/build/solver.memh` が作られます．
`./test/test_8puzzle`で `make test` することで，ランダムなパズルを生成して初期盤面を埋め込んだ `memory.memh` 作成し，実行結果をチェックします．
生成したパズルの難易度によって数秒から数時間を要します．
