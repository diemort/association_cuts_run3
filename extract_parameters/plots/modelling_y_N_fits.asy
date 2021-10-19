import root;
import pad_layout;

string f = "../analyze.root";

string arm = "arm 1";

string xangle = "130";

string x_N_bins[], xb_labels[];
//x_N_bins.push("6_2.75"); xb_labels.push("$x \approx 2.75$");
x_N_bins.push("7_3.25"); xb_labels.push("$x \approx 3.25$");
x_N_bins.push("10_4.75"); xb_labels.push("$x \approx 4.75$");
x_N_bins.push("15_7.25"); xb_labels.push("$x \approx 7.25$");
x_N_bins.push("24_11.75"); xb_labels.push("$x \approx 11.75$");

string quantities[], q_labels[];
quantities.push("de_x_mean"); q_labels.push("mean of $\De x$");
quantities.push("de_x_rms"); q_labels.push("RMS of $\De x$");
quantities.push("de_y_mean"); q_labels.push("mean of $\De y$");
quantities.push("de_y_rms"); q_labels.push("RMS of $\De y$");

//----------------------------------------------------------------------------------------------------

NewPad(false);
for (int xbi : x_N_bins.keys)
	NewPadLabel(xb_labels[xbi]);

for (int qi : quantities.keys)
{
	NewRow();

	NewPadLabel(q_labels[qi]);

	for (int xbi : x_N_bins.keys)
	{
		NewPad("$y_{\rm N}\ung{mm}$", q_labels[qi]);

		string base = arm + "/" + xangle + "/" + quantities[qi] + "/slices/h_prof_" + x_N_bins[xbi];

		draw(RootGetObject(f, base + ""), "vl,d0", blue);
		draw(RootGetObject(f, base + "|ff"), "l", red);

		xlimits(-10, +10, Crop);
	}
}
