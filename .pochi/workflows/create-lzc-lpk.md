Please help create a LZC lpk package for the user requested image or docker compose file, following these guidelines:

- There are some bash format variable `${PKG_PREFIX}` in this doc, please refer to `.pochi/.env` file to check and use the value when you need to use it.
- A lzc lpk is a folder that contains a `lzc-build.yml` file and a `manifest.yaml` file inside the apps folder.
- If there is a folder existed but did not contained the lzc related files, it's fine to reuse it and create the lzc manifests within it.
- the folder could be package into lpk by running `lzc-cli project build` in its folder.
- you may need a icon.png file, please try to download one and user may replace it later.
- `lzc-build.yml` file should be like the following, it doest not need to be changed in most cases:

```yaml
manifest: ./manifest.yml
pkgout: ./
icon: ./icon.png
devshell:
  routes:
    - /=http://127.0.0.1:3000
```

- `manifest.yml` file should be like the following, it should be modified depending on the user's request info:

```yaml
lzc-sdk-version: 0.1
package: app.ikw.lzc.kite
version: 0.0.1
name: kite
description: A modern, lightweight Kubernetes dashboard
license: https://choosealicense.com/licenses/apache-2.0
homepage: https://github.com/zxh326/kite
application:
  subdomain: kite
  routes:
  - /=http://$uid.web.app.ikw.lzc.kite.lzcapp:8080
  multi_instance: true
locales:
  zh:
    name: "财富自由计算器"
    description: "基于你当前资产和支出计算的财富自由规划工具，支持通胀调整和数据可视化"
  zh_CN:
    name: "财富自由计算器"
    description: "基于你当前资产和支出计算的财富自由规划工具，支持通胀调整和数据可视化"
  en:
    name: "FIRE Cal"
    description: "A Calculator and Charts for FIRE (Financial Independence, Retire Early)"
services:
  web:
    image: ghcr.io/kweizh/kite:v0.1.0
    environment:
    - TZ=Asia/Shanghai
    binds:
    - /lzcapp/var/data:/home/nonroot/.kube
```

- please use ${PKG_PREFIX} as package prefix
- please generate the name(CamelCase), description, license, homepage base on your knowledge.
- please generate the application and services base on the example.
- please generate the application introduce and detail in short in Chinese as output(do not include in yaml).
- please always use `/lzcapp/var/data` for persistent storage.
- please use `lzc-cli app install TARGET.lpk` to install the lpk package after building.
- for the image, please use the following command to sync the image to lzc registry, and use the lzc image in `manifest.yml`:

```bash
lzc-cli appstore copy-image IMAGE
```
