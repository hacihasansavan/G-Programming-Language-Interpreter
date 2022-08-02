#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int yyerror(char* s);
int yylex();
int yyparse();
	
typedef struct
{
	int* arr;
	int size;
	int capacity;
}Container;

typedef struct
{
	char id[16];
	int val;
}Input;

typedef struct
{
	Input* inp;
	int size;
	int capacity;
}IDCont;

IDCont* id_cont;

void _createIdCont()
{
	id_cont = (IDCont*)malloc(sizeof(IDCont));
	id_cont->size = 0;
	id_cont->capacity = 1;
	id_cont->inp = (Input*)malloc(sizeof(Input));
}

void _updateCapacity()
{
	id_cont->capacity *= 2;
	id_cont->inp = (Input*)realloc(id_cont->inp, sizeof(Input) * id_cont->capacity);
}

int _isItThere(char* id)
{
	for(int i=0 ; i < id_cont->size ; ++i){
        if(strcmp(id_cont->inp[i].id, id) == 0)
			return i;
    }
	return -1;
}

void _addInput(char* id, int val)
{
	int i;
	if((i = _isItThere(id)) != -1)
	{
		id_cont->inp[i].val = val;
		return;
	}

	if(id_cont->size == id_cont->capacity)
		_updateCapacity();

	strcpy(id_cont->inp[id_cont->size].id, id);
	id_cont->inp[id_cont->size].val = val;
	++(id_cont->size);
}

Input* _getInput(char* id)
{
	int i;
	if((i = _isItThere(id)) == -1)
		return NULL;
	return &id_cont->inp[i];
}

void _free()
{
	if(id_cont != NULL)
	{
		if(id_cont->inp != NULL)
			free(id_cont->inp);
		free(id_cont);
	}
}


void startInterpreter()
{
	yyparse();
}
Container* _initializer()
{
	Container* vec = (Container*)malloc(sizeof(Container));

	vec->size = 0;
	vec->capacity = 1;
	vec->arr = (int*)malloc(sizeof(int));

	return vec;
}

void _update(Container* vec)
{
	Container* v = vec;

	v->capacity *= 2;
	v->arr = (int*)realloc(v->arr, sizeof(int) * v->capacity);
}

Container* _addItem(Container* vec, int item)
{
	if(vec == NULL)
		vec = _initializer();

	Container* v = vec;

	if(v->size == v->capacity)
		_update(v);

	v->arr[v->size] = item;
	++v->size;

	return v;
}

Container* _appendItem(Container* vec, int item)
{
	Container* v = _initializer();
	Container* v2 = vec;

	_addItem(v, item);

	if(v2)
		for(int i=0 ; i < v2->size ; ++i)
			_addItem(v, v2->arr[i]);

	return v;
}

Container* _concatinate(Container* vec1, Container* vec2)
{
	Container* v = _initializer();

	if(vec1 != NULL)
	{
		Container* v1 = vec1;

		for(int i=0 ; i < v1->size ; ++i)
			_addItem(v, v1->arr[i]);
	}

	if(vec2 != NULL)
	{
		Container* v2 = vec2;

		for(int i=0 ; i < v2->size ; ++i)
			_addItem(v, v2->arr[i]);
	}

	return v;
}

void _print(Container* vec)
{
	if(vec == NULL)
	{
		printf("NULL\n");
		return;
	}

	Container* vecc = (Container*)vec;

	if(vecc->size == 0)
	{
		printf("()\n");
		return;
	}

	printf("(");
	for(int i=0 ; i < vecc->size ; ++i)
	{
		printf("%d",vecc->arr[i]);
		if(i < vecc->size - 1)
			printf(" ");
	}
	printf(")\n");
}
int _pow(int b, int pow) {
    if (pow != 0)
        return (b * _pow(b, pow - 1));
    else return 1;
}


