all:float double


float: traspuesta.cu
	nvcc traspuesta.cu -o ../build/float.out -lineinfo --ptxas-options=-v  -L /opt/cuda/lib64 -I /opt/cuda/include -D ELEMENT_TYPE
double: traspuesta.cu
	nvcc traspuesta.cu -o ../build/double.out -lineinfo --ptxas-options=-v  -L /opt/cuda/lib64 -I /opt/cuda/include

