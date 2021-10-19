import root;
import pad_layout;

string topDir = "../simu/1E5/";

string arm = "1";

string xangles[];
xangles.push("130");

for (string xangle : xangles)
{
	string f = topDir + "xangle_" + xangle + "/output_xy_distributions.root";
	string dir_base = "arm " + arm;

	NewPadLabel("arm " + arm);

	NewRow();

	// ----- x plots -----

	pen p = blue;

	NewPadLabel("$\De x \equiv x^F - x^N$");

	NewPad("$\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_de_x"), "vl,eb,lM,lR", p);
	AttachLegend();

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "mean of $\De x\ung{mm}$";
	draw(RootGetObject(f, dir_base + "/p2_de_x_vs_x_y"), "def");
	limits((0, -7), (15, +7), Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "RMS of $\De x\ung{mm}$";
	draw(RootGetObject(f, dir_base + "/h2_rms_de_x_vs_x_y"), "def");
	limits((0, -7), (15, +7), Crop);

	/*
	NewPad("$x_{\rm N}\ung{mm}$", "mean of $\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/p_de_x_vs_x"), "vl", p);
	xlimits(0, 15, Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "RMS of $\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_rms_de_x_vs_x"), "vl", p);
	xlimits(0, 15, Crop);

	NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/p_de_x_vs_y"), "vl", p);
	xlimits(-10, +10, Crop);

	NewPad("$y_{\rm N}\ung{mm}$", "RMS of $\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_rms_de_x_vs_y"), "vl", p);
	xlimits(-10, +10, Crop);
	*/

	// ----- y plots -----

	NewRow();

	pen p = red;

	NewPadLabel("$\De y \equiv y^F - y^N$");

	NewPad("$\De y\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_de_y"), "vl,eb,lM,lR", p);
	AttachLegend();

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "mean of $\De y\ung{mm}$";
	draw(RootGetObject(f, dir_base + "/p2_de_y_vs_x_y"), "def");
	limits((0, -7), (15, +7), Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "RMS of $\De y\ung{mm}$";
	draw(RootGetObject(f, dir_base + "/h2_rms_de_y_vs_x_y"), "def");
	limits((0, -7), (15, +7), Crop);

	/*
	NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De y\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/p_de_y_vs_y"), "vl", p);
	xlimits(-10, +10, Crop);

	NewPad("$y_{\rm N}\ung{mm}$", "RMS of $\De y\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_rms_de_y_vs_y"), "vl", p);
	xlimits(-10, +10, Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "mean of $\De y\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/p_de_y_vs_x"), "vl", p);
	xlimits(0, 15, Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "RMS of $\De y\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_rms_de_y_vs_x"), "vl", p);
	xlimits(0, 15, Crop);
	*/

	GShipout("per_xangle_plots_" + xangle);
}
