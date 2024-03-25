pragma circom  2.0.0;

template MiMC5() {
    
    signal input x;
    signal input k;
    signal output h;

    var nRounds = 10;

    var c[nRounds] = [
    0,
    56197349996965722917794284464345868029706507204984139663551107584017756217050,
    23186340927598205864155452604847830020695963927013452973441353519218905912468,
    91955575461240042624201656960424709822986341776786485727605009840795770391599,
    76426741095576825474653116946311097200468484620618340475012108007573216047613,
    78677843538918958886404031483670405503014842870908130523214002116564651197448,
    90449845223914035643627862183861766603822553140389298016261669930290012000030,
    47957586356784037609228808857308587109627631434551643887234644622732636493634,
    49843367271922103057899586986745636846528039255492217740753415640575325579318,
    88427003697368194419950371945298363770325024233228603760452932519164894610120
    ];

    signal lastOutput[nRounds + 1];
    var base[nRounds];
    signal base2[nRounds];
    signal base4[nRounds];

    lastOutput[0] <== x;

    for(var i = 0; i < nRounds; i++){
        base[i] = lastOutput[i] + k + c[i];
        base2[i] <== base[i] * base[i];
        base4[i] <== base2[i] * base2[i];

        lastOutput[i + 1] <== base4[i] * base[i];
    } 

    h <== lastOutput[nRounds] + k;

}

component main = MiMC5();