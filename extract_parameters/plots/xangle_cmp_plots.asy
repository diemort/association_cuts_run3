import root;
import pad_layout;

string topDir = "../simu/1E5/";

string arm = "1";
string dir_base = "arm " + arm;

string xangles[];
pen xangle_pens[];
xangles.push("100"); xangle_pens.push(blue);
xangles.push("130"); xangle_pens.push(red);
xangles.push("160"); xangle_pens.push(heavygreen);

//----------------------------------------------------------------------------------------------------

NewPad("$x_{\rm N}\ung{mm}$", "mean of $\De x\ung{mm}$");

for (int xai : xangles.keys)
{
	string f = topDir + "xangle_" + xangles[xai] + "/output_xy_distributions.root";
	draw(RootGetObject(f, dir_base + "/p_de_x_vs_x"), "vl,eb", xangle_pens[xai]);
}

xlimits(0, 15, Crop);

//----------------------------------------------------------------------------------------------------

NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De x\ung{mm}$");

for (int xai : xangles.keys)
{
	string f = topDir + "xangle_" + xangles[xai] + "/output_xy_distributions.root";
	draw(RootGetObject(f, dir_base + "/p_de_x_vs_y"), "vl,eb", xangle_pens[xai]);
}

xlimits(-10, +10, Crop);

//----------------------------------------------------------------------------------------------------

NewRow();

NewPad("$y_{\rm N}\ung{mm}$", "mean of $\De y\ung{mm}$");

for (int xai : xangles.keys)
{
	string f = topDir + "xangle_" + xangles[xai] + "/output_xy_distributions.root";
	draw(RootGetObject(f, dir_base + "/p_de_y_vs_y"), "vl,eb", xangle_pens[xai]);
}

xlimits(-10, +10, Crop);
