import root;
import pad_layout;

string topDir = "../";

string f_mc = topDir + "simu/test2_1E4/mc_2018_eff_mc.root";
string f_mc_ref = topDir + "simu/off_pre3_1E4/mc_2018_eff_mc.root";

string f_data = "mc_2018_eff_data.root";

string arms[];
arms.push("0");
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

		draw(RootGetObject(f_mc, "arm" + arms[ai] + "/" + n_protons[npi] + "/p_eff_vs_xi"), "eb", black);	
		draw(RootGetObject(f_mc_ref, "arm" + arms[ai] + "/" + n_protons[npi] + "/p_eff_vs_xi"), "eb", red + dashed);

		//draw(RootGetObject(f_data, "arm " + arms[ai] + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_eff2_vs_xi_N"), "eb", red);	
		//draw(RootGetObject(f_data, "arm " + arms[ai] + "/exp prot " + n_protons[npi] + "/nsi = 7.0/p_eff2_vs_xi_N"), "eb", blue);	

		limits((0, 0.3), (0.2, 1.1), Crop);
	}
}
