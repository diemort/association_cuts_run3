import root;
import pad_layout;

string f = "../analyze.root";

string arm = "arm 0";

string xangles[];
pen xa_pens[];
xangles.push("100"); xa_pens.push(red);
xangles.push("130"); xa_pens.push(blue);
xangles.push("160"); xa_pens.push(heavygreen);

string quantities[], q_labels[], q_parameters[][];
quantities.push("de_x_mean"); q_labels.push("mean of $\De x$"); q_parameters.push(new string[] {"0", "1"});
quantities.push("de_x_rms"); q_labels.push("RMS of $\De x$"); q_parameters.push(new string[] {"0", "1"});
quantities.push("de_y_mean"); q_labels.push("mean of $\De y$"); q_parameters.push(new string[] {"0", "1"});
quantities.push("de_y_rms"); q_labels.push("RMS of $\De y$"); q_parameters.push(new string[] {"0", "1"});

TF1_x_min = 3.0;
TF1_x_max = 12.;

//----------------------------------------------------------------------------------------------------

for (int qi : quantities.keys)
{
	NewRow();

	NewPadLabel(q_labels[qi]);

	for (int pi : q_parameters[qi].keys)
	{
		NewPad("$x_{\rm N}\ung{mm}$", "parameter " + q_parameters[qi][pi]);

		for (int xai : xangles.keys)
		{
			string base = arm + "/" + xangles[xai] + "/" + quantities[qi] + "/g_param_" + q_parameters[qi][pi];

			pen p = xa_pens[xai];

			draw(RootGetObject(f, base + ""), "p", mCi+2pt+p, "xangle " + xangles[xai]);
			draw(RootGetObject(f, base + "|ff"), "l", p + dashed);
		}

		xlimits(0, +15, Crop);
	}
}

frame f_legend = BuildLegend();

NewPad(false);
add(f_legend);
