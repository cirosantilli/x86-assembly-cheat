/* Trying to force out tail call optimization. */

int func2(
    int i_0,  int i_1,  int i_2,  int i_3,
    int i_4,  int i_5,  int i_6,  int i_7,
    int i_8,  int i_9,  int i_10, int i_11,
    int i_12, int i_13, int i_14, int i_15
) {
    return
        i_0  + i_1  + i_2  + i_3  +
        i_4  + i_5  + i_6  + i_7  +
        i_8  + i_9  + i_10 + i_11 +
        i_12 + i_13 + i_14 + i_15
    ;
}

int func(
    int i_0,  int i_1,  int i_2,  int i_3,
    int i_4,  int i_5,  int i_6,  int i_7,
    int i_8,  int i_9,  int i_10, int i_11,
    int i_12, int i_13, int i_14, int i_15
) {
    return func2(
        i_12 , i_13 , i_14 , i_15 ,
        i_8  , i_9  , i_10 , i_11 ,
        i_4  , i_5  , i_6  , i_7  ,
        i_0  , i_1  , i_2  , i_3
    );
}

int main(int argc, char **argv) {
    (void)argv;
    return func(
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc
    );
}
