## 主程序

- test.m *使用样例文件进行虚拟测试，用来保证函数正确运行的测试脚本*

- main.m *主脚本，包含了一轮重建的所有步骤*

## 预处理函数

- makeMask.m *将用PS初步处理后的掩码图进一步处理*

- calLight.m *利用图片中的标定球计算光源方向*

- calLightSun.m *按照文件所给时间，经纬，方向，倾角获得一系列太阳光照方向向量*

- sunVec.m *输入地理位置等信息，返回相机坐标系下的太阳光照单位方向向量*

## 核心函数

- calNormals.m *利用光源信息和图片组计算表面法线*

- calDepth.m *从法线图计算深度图*

## 辅助函数

- toUnitVector.m 		*转换单位向量*

- errorAnalyse.m 		*与GT对比分析生成的法线图误差*

- getBumpMapping.m *将图像的法线恢复到[-1,1]的double空间*

## tga文件的输入输出相关

- tga_read_header.m

- tga_read_image.m

- tga_toolbox_license.txt

- tgas2bmp.m

## 绘图与导出

- drawBall.m *绘制球的法线针图*

- surf2stl.m *将曲面数据导出为stl文件*

- toNormalImg.m *将法线矩阵转为可视形式*
