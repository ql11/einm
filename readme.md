********
2020年4月23日18点10分

1. 垂直入射

入射位置XY: 0-144 mm, 间隔0.25 mm;

入射Z位置: Z=50 mm,

电子接收灵敏区范围: 140 mm*140 mm, 即XY: -70mm到70mm, Z=-330.5 mm

电子能量: 20 keV, 50 keV, 100keV, 300keV, 600keV, 1000keV


2. 向内斜入射,倾角170度 （与正z轴夹角170，与x轴夹角180）

入射位置XY: 0-144 mm, 间隔0.25 mm;

入射Z位置: Z=50 mm,

电子接收灵敏区范围: 140 mm*140 mm, 即XY: -70mm到70mm, Z=-330.5 mm

电子能量: 20 keV, 50 keV, 100keV, 300keV, 600keV, 1000keV


计算存储的数据:

所有计算粒子的入射位置, 达到灵敏平面的位置


********
2020年4月20日18点32分
新需求，要求将击中电子的速度和击中点位置进行组合成为一个mat文件
![](https://gitee.com/qin_lang/img/raw/master/Picgo/20200420183130.png)

*************
2020年3月30日11点54分
x,y分别分成三份
将所有的点分成9份，分别对应
number|1|2|3|4|5|6|7|8|9
 :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: 
position|(0,0)|(0,1)|(0,2)|(1,0)|(1,1)|(1,2)|(2,0)|(2,1)|(2,2)
φ range|-180,-50 170,180|-125,-75 160,180|-125,-75|-180,-150|-180,-100|-170,-100|-140,-100|-180,-150 160,180|-180,-125|-150,-120
θ range|165,180|160,180|160,180|160,180|158,180|150,180|150,180|150,180|150,180




****************************
2020年3月27日08点36分
# 第一象限全部电子计算
能量|是否已完成
:-:|:-:
100|x
300|x
500|x
700|x
1000|x
