import root;
import pad_layout;

string topDir = "../";

string f = "simu/default/4E5/mc_eff_data.root";

string arms[];
//arms.push("0");
arms.push("1");

string n_protons[];
n_protons.push("1");
n_protons.push("2");
n_protons.push("3");
n_protons.push("4");

string n_sigmas[];
pen p_nsis[];
n_sigmas.push("3.0"); p_nsis.push(red);
n_sigmas.push("5.0"); p_nsis.push(blue);
n_sigmas.push("7.0"); p_nsis.push(heavygreen);

xTicksDef = LeftTicks(5., 1.);
yTicksDef = RightTicks(0.05, 0.01);

//----------------------------------------------------------------------------------------------------

NewPad(false);
for (int npi : n_protons.keys)
	NewPadLabel(n_protons[npi] + "proton(s) acc/exp");

for (int ai : arms.keys)
{
	NewRow();

	NewPadLabel("arm " + arms[ai]);

	for (int npi : n_protons.keys)
	{
		NewPad("$x_{\rm N}\ung{mm}$", "efficiency");

		for (int nsi : n_sigmas.keys)
		{
			draw(RootGetObject(topDir + f, "arm " + arms[ai] + "/exp prot " + n_protons[npi] + "/nsi = " + n_sigmas[nsi] + "/p_eff2_vs_x_N"),
				"eb", p_nsis[nsi], "$n_\si = " + n_sigmas[nsi] + "$");
		}

		limits((0, 0.7), (20, 1.05), Crop);

		xaxis(YEquals(1., false), dashed);
	}

	frame f_legend = BuildLegend();

	NewPad(false);
	attach(f_legend);
}

GShipout(vSkip=1mm);
