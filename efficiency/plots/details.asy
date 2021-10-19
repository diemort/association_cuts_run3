import root;
import pad_layout;

string topDir = "../";

string f = topDir + "simu/default/1E4/mc_eff_data.root";

string arm = "0";

string n_protons[];
n_protons.push("1");
n_protons.push("2");
n_protons.push("3");
n_protons.push("4");

real x_N_max = 20;

//----------------------------------------------------------------------------------------------------

NewPad(false);
AddToLegend("<arm: " + arm);
AttachLegend();

NewPadLabel("efficiency");
NewPadLabel("non-unique N-F match");
NewPadLabel("non-complete N-F match");
NewPadLabel("complete N-F match");

for (int npi : n_protons.keys)
{
	NewRow();

	NewPadLabel("exp.~protons: " + n_protons[npi]);

	NewPad("$x_{\rm N}\ung{mm}$", "efficiency");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_eff2_vs_x_N"), "eb", blue, "$n_\si = 3$");	
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 5.0/p_eff2_vs_x_N"), "eb", red, "$n_\si = 5$");	
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 7.0/p_eff2_vs_x_N"), "eb", heavygreen, "$n_\si = 7$");	
	limits((0, 0.5), (x_N_max, 1.1), Crop);
	AttachLegend(BuildLegend(E), E);

	/*
	NewPad("$x_{\rm N}\ung{mm}$", "fraction");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_match_unique"), "eb", blue);	
	limits((0, 0.5), (x_N_max, 1.1), Crop);	
	*/

	NewPad("$x_{\rm N}\ung{mm}$", "fraction");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_match_non_unique"), "eb", red);	
	limits((0, 0.0), (x_N_max, 0.5), Crop);	

	NewPad("$x_{\rm N}\ung{mm}$", "fraction");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_signature_0"), "eb", blue, "sig !x, !y");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_signature_1"), "eb", red, "sig x, !y");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_signature_2"), "eb", heavygreen, "sig !x, y");
	limits((0, 0.0), (x_N_max, 1.05), Crop);
	AttachLegend();

	NewPad("$x_{\rm N}\ung{mm}$", "fraction");
	draw(RootGetObject(f, "arm " + arm + "/exp prot " + n_protons[npi] + "/nsi = 3.0/p_fr_signature_12"), "eb", magenta, "sig x, y");
	limits((0, 0.0), (x_N_max, 1.05), Crop);	
	AttachLegend();
}

GShipout(vSkip=0mm);
