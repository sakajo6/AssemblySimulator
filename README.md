# CPU-group5-simu

## 各ファイル説明
    - asm_simディレクトリがassemblyのシミュレータ

### make
    - `cd asm_sim`
    - command `make`
    
### execute
    - command `./sim`
    - ./asm_sim/inputに実行したいassemblyを格納して`./sim`を実行。(複数ファイル可)

### IO
    - 入力(.sld)を./asm_sim/inputに格納して`./sim`
    - 出力(.ppm)を./asm_sim/outputに出力

### 実行時オプション
    - `--bin`: registerの値をbinary表現で出力
    - `--brkall`: すべての命令でブレークポインタを起動

### breakpoint
    - 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
    ```
    *	ble		x6, x7, ret01
    ``` 
