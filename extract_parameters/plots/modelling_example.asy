import root;
import pad_layout;

string f = "../analyze.root";

string arm = "arm 1";

string xangle = "130";

NewPad("$y_N\ung{mm}$", "$\De x\ung{mm}$");
TH1_x_min = -6;
TH1_x_max = +6;
draw(RootGetObject(f, arm + "/" + xangle + "/de_x_mean/slices/h_prof_15_7.25"), "vl", blue);
draw(RootGetObject(f, arm + "/" + xangle + "/de_x_mean/slices/h_prof_15_7.25|ff"), "def", red);
limits((-6, -0.6), (+6, 0.), Crop);

NewPad("$x_N\ung{mm}$", "$p_0$");
draw(RootGetObject(f, arm + "/" + xangle + "/de_x_mean/g_param_0"), "p,l", blue, mCi+2pt+blue);
draw(RootGetObject(f, arm + "/" + xangle + "/de_x_mean/g_param_0|ff"), "def", red);
//limits((-6, -0.6), (+6, 0.), Crop);
