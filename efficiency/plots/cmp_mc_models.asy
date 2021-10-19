import root;
import pad_layout;

string topDir = "../";

string files[], f_labels[];
pen f_pens[];
files.push("simu/model1/1E4/mc_eff_mc.root"); f_labels.push("model1"); f_pens.push(blue);
files.push("simu/model2/1E4/mc_eff_mc.root"); f_labels.push("model2"); f_pens.push(red);
files.push("simu/model2-5si/1E4/mc_eff_mc.root"); f_labels.push("model2-5si"); f_pens.push(green);
files.push("simu/model2-3si/1E4/mc_eff_mc.root"); f_labels.push("model2-3si"); f_pens.push(magenta);

string arms[];
//arms.push("0");
arms.push("1");

string n_protons[];
n_protons.push("1");
n_protons.push("2");
n_protons.push("3");
n_protons.push("4");

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
		NewPad("$\xi$", "efficiency");

		for (int fi : files.keys)
			draw(RootGetObject(topDir + files[fi], "arm" + arms[ai] + "/" + n_protons[npi] + "/p_eff_vs_xi"), "eb", f_pens[fi], f_labels[fi]);	

		limits((0, 0.3), (0.2, 1.1), Crop);
	}

	frame f_legend = BuildLegend();

	NewPad(false);
	attach(f_legend);
}
