#include <stdio.h>
#include <stdlib.h>
#include <circle.h>
#include <donut.h>

void read_donut(Donut *d){
	float inner, outer;
	printf("Outer radius of donut? ");
	scanf("%f",&outer);
	printf("Inner radius of donut? ");
	scanf("%f",&inner);

	//validate
	if(outer <= inner) {
		fprintf(stderr, "Invalid Donut. Try Again\n");
		exit(-1);
	}
	else {
	
		(d->outer).rad = outer;
		(d->inner).rad = inner;
	}
	return;
}


float donut_area(Donut *d){
	return (circ_area(&(d->outer)) - circ_area(&(d->inner)));
}

float donut_peri(Donut *d){
	return (circ_perimtr(&(d->outer)) + circ_perimtr(&(d->inner)));
}

