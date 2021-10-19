all: analyze

analyze: analyze.cc
	g++ `root-config --libs` -lMinuit `root-config --cflags` analyze.cc -o analyze