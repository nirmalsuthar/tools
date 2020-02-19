//#include<circle.h>

typedef struct _donut Donut;

struct _donut {
	Circle inner;
	Circle outer;
};


void read_donut(Donut *d);
float donut_area(Donut *d);
float donut_peri(Donut *d);

