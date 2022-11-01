# CPU-group5-simu

## 各ファイル説明
    - asm_simディレクトリがassemblyのシミュレータ

### make
    - command `make`
### execute
    - command `./simu ./fib.s`
    - ファイルの末尾に改行入れないと動かない...

#### 実行時オプション
    - `--asm`: 機械語コードを./asm_sim内にbin.txtで出力
    - `--stats`: 各命令の実行回数を./asm_sim内に./stats.txtで出力
    - `--debug`: 各asm命令をどのようにパースしたかを標準出力に出力(simulator係用)

### breakpoint
    - 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
    ```
    *	ble		x6, x7, ret01
    ``` 
