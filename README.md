# kjmkznr/wsl-isucon11-prior

## これはなに

ISUCON11 Priorの環境をWSL2上に構築するスクリプトです。

## 構築

PowerShell上で以下を実行します。

```
# ダウンロード
git clone https://github.com/kjmkznr/wsl-isucon11-prior.git

# ディレクトリに移動
cd wsl-isucon11-prior

# 一時的にPowerShell実行を許可
Set-ExecutionPolicy RemoteSigned -Scope Process

# 構築スクリプト実行(引数はDistro名、インストールパス)
.\build.ps1 isucon11-prior .\isucon11-prior
```

## 実行

```
wsl.exe -d isucon11-prior
```

### サイト表示確認

https://localhost/

### ベンチマーク実行

```
cd ~isucon/
bin/benchmark
```

## 関連

* [ISUCON11 Prior](https://github.com/isucon/isucon11-prior)
* [matsuu/wsl-isucon9-qualifier](https://github.com/matsuu/wsl-isucon9-qualifier)
* [matsuu/wsl-isucon10-qualifier](https://github.com/matsuu/wsl-isucon10-qualifier)

## TODO

* エラー制御
  * 二重実行の防止
* `/etc/resolv.conf` 周りの調整
* PowerShellなんもわからん

