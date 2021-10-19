import root;
import pad_layout;

string topDir = "../simu_1E7/";

string arm = "1";

string xangles[];
xangles.push("130");

//----------------------------------------------------------------------------------------------------

real pow(real x, real e)
{
	return x^e;
}

//----------------------------------------------------------------------------------------------------

string quantity = "";

real x_N_gl = 0, xangle_gl = 0;

real model(real y_N)
{
	real x_N = x_N_gl;
	real xangle = xangle_gl;

	if (quantity == "de_x_mean")
		return (-0.530895+0.112595*x_N+-0.006785*x_N*x_N) - (0.046487+0.179333/x_N)*abs(y_N);

	if (quantity == "de_x_rms")
		return (0.091692+0.009316*x_N) + (-0.000727)*y_N*y_N;

	if (quantity == "de_y_mean")
		return (0.672525+-0.619398/x_N)*erf(y_N/(0.968499+0.597136*x_N));

	if (quantity == "de_y_rms")
		return (0.015202+0.962944/x_N/x_N) + (0.009804+-7.710241/pow(x_N,5))*abs(y_N);

	return 0;
}

//----------------------------------------------------------------------------------------------------

void DrawProfiles(RootObject o)
{
	real xs[] = {3.25, 4.25, 6.25, 9.25, 11.75};

	for (int ix : xs.keys)
	{
		real x = xs[ix];
		int bi = o.oExec("GetXaxis").iExec("FindBin", x);

		RootObject profile = o.oExec("ProjectionY", "neco", bi, bi);

		pen p = StdPen(ix);
		
		real x_cen = o.oExec("GetXaxis").rExec("GetBinCenter", bi);
		string l = format("$x_{\rm N} = %.2f\un{mm}$", x_cen);

		draw(profile, "vl", p, l);

		x_N_gl = x_cen;
		draw(graph(model, -6, +6), p + dashed);
	}
}

//----------------------------------------------------------------------------------------------------

for (string xangle : xangles)
{
	string f = topDir + "xangle_" + xangle + "/output_xy_distributions.root";
	string dir_base = "arm " + arm;

	// ----- x plots -----

	pen p = blue;

	NewPadLabel("$\De x \equiv x^F - x^N$");

	/*
	NewPad("$\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_de_x"), "vl,eb,lM,lR", p);
	AttachLegend();
	*/

	RootObject h2_mean = RootGetObject(f, dir_base + "/p2_de_x_vs_x_y");
	RootObject h2_rms = RootGetObject(f, dir_base + "/h2_rms_de_x_vs_x_y");

	/*
	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "mean of $\De x\ung{mm}$";
	draw(h2_mean, "def");
	limits((0, -7), (15, +7), Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "RMS of $\De x\ung{mm}$";
	draw(h2_rms, "def");
	limits((0, -7), (15, +7), Crop);
	*/

	NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De x\ung{mm}$");
	quantity = "de_x_mean";
	DrawProfiles(h2_mean);
	limits((-6, -0.8), (+6, 0), Crop);

	NewPad("$y_{\rm N}\ung{mm}$", "RMS of $\De x\ung{mm}$");
	quantity = "de_x_rms";
	DrawProfiles(h2_rms);
	xlimits(-6, +6, Crop);
	AttachLegend(NW, NE);

	// ----- y plots -----

	NewRow();

	pen p = red;

	NewPadLabel("$\De y \equiv y^F - y^N$");

	/*
	NewPad("$\De x\ung{mm}$");
	draw(RootGetObject(f, dir_base + "/h_de_y"), "vl,eb,lM,lR", p);
	AttachLegend();
	*/

	RootObject h2_mean = RootGetObject(f, dir_base + "/p2_de_y_vs_x_y");
	RootObject h2_rms = RootGetObject(f, dir_base + "/h2_rms_de_y_vs_x_y");

	/*
	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "mean of $\De y\ung{mm}$";
	draw(h2_mean, "def");
	limits((0, -7), (15, +7), Crop);

	NewPad("$x_{\rm N}\ung{mm}$", "$y_{\rm N}\ung{mm}$");
	TH2_zLabel = "RMS of $\De y\ung{mm}$";
	draw(h2_rms, "def");
	limits((0, -7), (15, +7), Crop);
	*/

	NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De y\ung{mm}$");
	quantity = "de_y_mean";
	DrawProfiles(h2_mean);
	xlimits(-6, +6, Crop);

	NewPad("$y_{\rm N}\ung{mm}$", "RMS of $\De y\ung{mm}$");
	quantity = "de_y_rms";
	DrawProfiles(h2_rms);
	//xlimits(-6, +6, Crop);
	limits((-6, 0), (+6, 0.2), Crop);
	AttachLegend(NW, NE);

	GShipout("per_xangle_plots_profiles_" + xangle);
}
