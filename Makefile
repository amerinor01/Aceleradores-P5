all:float double


float: traspuesta.cu
	nvcc traspuesta.cu -o float.out -lineinfo --ptxas-options=-v  -arch sm_35  -L /opt/cuda/lib64 -I /opt/cuda/include -D ELEMENT_TYPE
double: traspuesta.cu
	nvcc traspuesta.cu -o double.out -lineinfo --ptxas-options=-v  -arch sm_35  -L /opt/cuda/lib64 -I /opt/cuda/include

