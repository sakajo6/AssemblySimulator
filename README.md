# CPU-group5-simu

## 各ファイル説明
    - asm_simディレクトリがassemblyのシミュレータ

### make
    - command `make`
    
### execute
    - command `./sim`
    - ./asm_sim/inputに実行したいassemblyを格納して`./sim`を実行。(複数ファイル可)

#### 実行時オプション
    - `--stats`: 実行時の統計情報を./asm_sim/output/stats.txtに出力
    - `--debug`: 各asm命令をどのようにパースしたかを./asm_sim/output/debug.txtに出力(simulator係用)

### breakpoint
    - 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
    ```
    *	ble		x6, x7, ret01
    ``` 
