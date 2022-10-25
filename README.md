# CPU-group5-simu

## 各ファイル説明
    - asm_simディレクトリがassemblyのシミュレータ

### make
    - command `make`
### execute
    - command `./fibsimu ./fib.txt`
    - ファイルの末尾に改行入れないと動かない...

### breakpoint
    - 実行前に実行したいファイルの命令の先頭に'*'を記入して実行
    '''
    *	ble		x6, x7, ret01
    ''' 
