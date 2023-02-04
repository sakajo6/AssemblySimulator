# CPU-group5-simu

### 各ディレクトリ説明
- asm_sim:      assemblyのシミュレータ
- diff_check:   出力されたppmファイルと正規ppmファイルの差分チェック
- fpu_scan:     FPUのコード内の即値scan用
- fpu_sim:      FPUエミュレータ

### simulatorのmake方法
- `cd asm_sim`
- `make`:
    - `make`:       高速な実行ファイル生成
    - `make debug`: assertionなどdebugのための実行ファイル生成
        - ブレークポインタが使用可能
    - `make hard`:  cache, 分岐予測などhardware用の機能を追加した実行ファイル生成
    - `make stats`: stats(命令実行回数、labelアクセス回数)を記録する実行ファイル生成
    - `make prod`:  FPUエミュレータを用いた実行ファイル生成
    
### 入出力ファイル
- 入力ファイル
    - 以下を `./asm_sim/input`に格納
        - `*.sld`:          入力ファイル
        - `minrt.s`:        min_caml_startを含むアセンブリ
        - `libmincaml.s`:   いわゆるソフトウェア実装library
- 出力ファイル
    - 以下を`./asm_sim/output`に出力
        - `bin_debug.txt`:      アセンブラデバッグ用
        - `bin.txt`:            16進数の機械語
        - `debug.txt`:          各種デバッグ用. 命令, ラベル, 入力
        - `output.ppm`:         .ppm画像ファイル
        - `pcToFilepos.txt`:    pcから各命令を辞書引き
        - (`stats.txt`): 
            - `make hard`:  cache stats, branch prediction stats
            - `make stats`: 命令実行数, ジャンプ先カウント, lui/ori代入カウント

### 実行方法
- `./sim`
- 以下, 実行時オプション(併用可能). ただし, `make debug`のときのみ有効
    - `--bin`: registerの値をbinary表現で出力
    - `--brkall`: すべての命令でブレークポインタを起動
    - `--brknon`: すべてのブレークポインタを無視

### ブレークポイントについて
- 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
``` s
*	ble		x6, x7, ret01
``` 

### *.s記述時の注意点
- 行の先頭のインデントは`\t`
- オペコード, オペランドの空白は`\t`
- オペランド間の空白は `space`
- 行末の改行は`\n`
    - 各OSで改行文字が異なるので注意. compilerが出力したアセンブリファイルからコピペするのがよい
- アセンブリファイルの終端では改行のみ

``` s
# アセンブリ記述例
#   体裁整えるの難しいのでcompilerが
#   出力した.sファイルをコピペして編集
#   するのをお勧めします
label:
	addi	x2, x2, 408
	lw	x1, -404(x2)
	EXIT	

```