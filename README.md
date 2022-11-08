# CPU-group5-simu

## 各ファイル説明
    - asm_simディレクトリがassemblyのシミュレータ

### make
    - command `make`
### execute
    - command `./sim ./test/fib.s`
    - ファイルの末尾に改行入れないと動かない...

#### 実行時オプション
    - `--asm`: 機械語コードを./asm_sim/output/bin.txtに出力
    - `--stats`: 実行時の統計情報を./asm_sim/output/stats.txtに出力
    - `--debug`: 各asm命令をどのようにパースしたかを./asm_sim/output/debug.txtに出力(simulator係用)

### breakpoint
    - 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
    ```
    *	ble		x6, x7, ret01
    ``` 
