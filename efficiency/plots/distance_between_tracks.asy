import root;
import pad_layout;

string topDir = "../";

string f = topDir + "simu/default/1E5/output_xy_distributions.root";

string rp = "RP 103";

int rebin_x = 2, rebin_y = 5;

//----------------------------------------------------------------------------------------------------

NewPad("$x\ung{mm}$", "$\de x\ung{mm}$");
RootObject hist = RootGetObject(f, rp + "/h2_de_x_vs_x");
hist.vExec("Rebin2D", rebin_x, rebin_y);
draw(hist);

NewPad("$y\ung{mm}$", "$\de x\ung{mm}$");
RootObject hist = RootGetObject(f, rp + "/h2_de_x_vs_y");
hist.vExec("Rebin2D", rebin_x, rebin_y);
draw(hist);

NewRow();

NewPad("$x\ung{mm}$", "$\de y\ung{mm}$");
RootObject hist = RootGetObject(f, rp + "/h2_de_y_vs_x");
hist.vExec("Rebin2D", rebin_x, rebin_y);
draw(hist);

NewPad("$y\ung{mm}$", "$\de y\ung{mm}$");
RootObject hist = RootGetObject(f, rp + "/h2_de_y_vs_y");
hist.vExec("Rebin2D", rebin_x, rebin_y);
draw(hist);
