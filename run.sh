#/bin/bash
echo "This will build (if needed) and run an rstudio environment, with mxnet, in a docker component"
echo "Volume, container and image all all named rstudio"
docker info
docker build -t rstudio .
echo "Cleaning up previous containers"
docker kill rstudio 
docker rm rstudio
echo "Launching new contariner (rstudio)"
docker run -d -p 8787:8787 -v rstudio:/home/rstudio --name rstudio rstudio

echo "Rstudio now waiting for http connection on port 8787, user=rstudio, password=rstudio"
echo "Data was saved in data volume called rsdtudio"
