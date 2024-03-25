pragma circom  2.0.0;

template MiMC5Feistel() {
    signal input iL;
    signal input iR;
    signal input k;

    signal output oL;
    signal output oR;

    var nRounds = 20;
    var c[20] = [0,
    70228402099022274215281342088391220084253351952549754123361407470191625853182,
    84059812724668833627600774936992884484252350215222638458629675543120211395638,
    64373452879316215824873279823378710397944555772455836728383011727234467508133,
    20304880730378074252697394167940439745560233696410422815934631028828785653784,
    61550673463716433062848477711593658583440453753787787991257430320902304848320,
    94966432685757984173609501386235084651871204161354732796497483067895769692222,
    102562519813209862839777812888001628735258118868951731581716626833041843224308,
    3678986863272190311289490614652172812979468443504236006630083689801274253114,
    65367200278072852536213929617755861943488266958924649230980352237386306064871,
    21844669965668159164344676765968138795427982511625501899247320823270855495605,
    99110448926721779071383919943820220323527955008462328558989845488145169546436,
    75535666455830132271456045714517062980972844724474709222114319843565913197201,
    69401313627217926158110570278943177852178995646432487250660031548792833590365,
    76654542576956883006021465003944886714385456931009378971138381178438673862119,
    82098041840463165661502255284504439783283904245363812966256901542209247368509,
    39279816803069533778156183901350493353787419352623086326581410484555224261492,
    70414499925215908417532464039653547651945524911949096560125602271532695887377,
    9492842820598193973079125613590998692062999029987972924737282508147493678935,
    38359453317718956643539966689924658954549220768981898622155089174755517529217
    ];

    signal lastOutPutL[ nRounds + 1];
    signal lastOutPutR[ nRounds + 1];

    var base[nRounds];
    signal base2[nRounds];
    signal base4[nRounds];

    lastOutPutL[0] <== iL;
    lastOutPutR[0] <== iR;

    for (var i = 0; i < nRounds; i++){
        base[i] = lastOutPutR[i] + k + c[i];
        base2[i] <== base[i] * base[i];
        base4[i] <== base2[i] * base2[i];

        lastOutPutR[i + 1] <== lastOutPutL[i] + base[i] * base4[i];
        lastOutPutL[i + 1] <== lastOutPutR[i];
    }

    oL <== lastOutPutL[nRounds];
    oR <== lastOutPutR[nRounds];

}

template MiMC5Sponge(nInputs) {
    signal input k;
    signal input ins[nInputs];
    signal output o;

    signal lastR[nInputs + 1];
    signal lastC[nInputs + 1];

    lastR[0] <== 0;
    lastC[0] <== 0;

    component layers[nInputs];

    for(var i = 0; i < nInputs; i++){

        layers[i] = MiMC5Feistel();

        layers[i].iL <== lastR[i] + ins[i];
        layers[i].iR <== lastC[i];
        layers[i].k <== k;

        lastR[i + 1] <== layers[i].oL;
        lastC[i + 1] <== layers[i].oR;

    }

    o <== lastR[nInputs];

}

component main = MiMC5Sponge(2);