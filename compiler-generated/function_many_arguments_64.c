/* Now with 64 arguments, trying to break the red zone and force the stack to move.
 * But TODO why: fails in GCC 8.2, stack is still fixed.
 */

/* for i in `seq 0 15`; do echo "int i_$((i*4 + 0)), int i_$((i*4 + 1)), int i_$((i*4 + 2)), int i_$((i*4 + 3)),"; done */
int func(
    int i_0,  int i_1,  int i_2,  int i_3,
    int i_4,  int i_5,  int i_6,  int i_7,
    int i_8,  int i_9,  int i_10, int i_11,
    int i_12, int i_13, int i_14, int i_15,

    int i_16, int i_17, int i_18, int i_19,
    int i_20, int i_21, int i_22, int i_23,
    int i_24, int i_25, int i_26, int i_27,
    int i_28, int i_29, int i_30, int i_31,

    int i_32, int i_33, int i_34, int i_35,
    int i_36, int i_37, int i_38, int i_39,
    int i_40, int i_41, int i_42, int i_43,
    int i_44, int i_45, int i_46, int i_47,

    int i_48, int i_49, int i_50, int i_51,
    int i_52, int i_53, int i_54, int i_55,
    int i_56, int i_57, int i_58, int i_59,
    int i_60, int i_61, int i_62, int i_63
) {
    return
        /* for i in `seq 0 15`; do echo "i_$((i*4 + 0)) + i_$((i*4 + 1)) + i_$((i*4 + 2)) + i_$((i*4 + 3)) +"; done */
        i_0  + i_1  + i_2  + i_3  +
        i_4  + i_5  + i_6  + i_7  +
        i_8  + i_9  + i_10 + i_11 +
        i_12 + i_13 + i_14 + i_15 +

        i_16 + i_17 + i_18 + i_19 +
        i_20 + i_21 + i_22 + i_23 +
        i_24 + i_25 + i_26 + i_27 +
        i_28 + i_29 + i_30 + i_31 +

        i_32 + i_33 + i_34 + i_35 +
        i_36 + i_37 + i_38 + i_39 +
        i_40 + i_41 + i_42 + i_43 +
        i_44 + i_45 + i_46 + i_47 +

        i_48 + i_49 + i_50 + i_51 +
        i_52 + i_53 + i_54 + i_55 +
        i_56 + i_57 + i_58 + i_59 +
        i_60 + i_61 + i_62 + i_63
    ;
}

int main(int argc, char **argv) {
    (void)argv;
    return func(
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,

        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,

        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,

        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc,
        argc, argc, argc, argc
    );
}
