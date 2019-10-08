options(repos = 'https://mirrors.tuna.tsinghua.edu.cn/CRAN/')
install.packages(c('repr', 'IRdisplay', 'IRkernel'), type = 'source')
IRkernel::installspec(user = FALSE)