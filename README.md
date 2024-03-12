# AssemblySimulator

### 各ディレクトリ説明
- asm_sim:      assemblyのシミュレータ
- diff_check:   出力されたppmファイルと正規ppmファイルの差分チェック
- fpu_scan:     FPUのコード内の即値scan用
- fpu_sim:      FPUエミュレータ

### simulatorのmake方法
- `cd asm_sim`
- `make`:
    - `make`:       高速な実行ファイル生成
    - `make debug`: debugのための実行ファイル生成. ブレークポインタが使用可能
    - `make stats`: stats(命令実行回数、labelアクセス回数)を記録する実行ファイル生成
    - `make prod`:  stats機能, FPUエミュレート機能, キャッシュ機能, 分岐予測機能を含む実行ファイル生成
    
### 入出力ファイル
- `./asm_sim/files/****`を作成
    - ****は任意に定めることができる
- 入力ファイル
    - 以下を `./asm_sim/files/****`に格納
        - `*.sld`:          入力ファイル
        - `minrt.s`:        min_caml_startを含むアセンブリ
        - `libmincaml.s`:   いわゆるソフトウェア実装library
- 出力ファイル
    - 以下を`./asm_sim/files/****`に出力
        - `bin_debug.txt`:      アセンブラデバッグ用
        - `binary.bin`          binary形式の機械語
        - `binary.txt`:         16進数の機械語
        - `debug.txt`:          各種デバッグ用. 命令, ラベル, 入力
        - `output.bin`:         binary形式画像ファイル
        - `output.ppm`:         .ppm画像ファイル
        - `pcToFilepos.txt`:    pcから各命令を辞書引き
        - (`stats.txt`): 
            - `make stats`: 命令実行数, ジャンプ先カウント, lui/ori代入カウント
            - `make prod`:  命令実行数, キャッシュ, 分岐予測等の統計情報

### 実行方法
- `./asm_sim`で./sim`
- 実行するアセンブリが入っているディレクトリを指定
``` s
# example
<<< please input folder name
./files/example
```
- 以下, 実行時オプション(併用可能). ただし, `make debug`のときのみ有効
    - `./sim --bin`: registerの値をbinary表現で出力
    - `./sim --brkall`: すべての命令でブレークポインタを起動
    - `./sim --brknon`: すべてのブレークポインタを無視

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

### 機械語生成
- ./asm_sim/output内で以下を実行
``` sh
cat bin.txt | awk -F "[\t\n,\]" '{print $1}' | tr -dc [0-9a-f] | xxd -r -p > binary_bin.bin
```
