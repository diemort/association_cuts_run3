import root;
import pad_layout;

string f = "../simu/1E5/xangle_130/output_optics.root";

string rps[];
rps.push("23");
rps.push("123");

string graphs[];
graphs.push("g_v_x_vs_xi");
graphs.push("g_L_x_vs_xi");
graphs.push("g_x_D_vs_xi");
graphs.push("g_v_y_vs_xi");
graphs.push("g_L_y_vs_xi");
graphs.push("g_y_D_vs_xi");

for (int gi : graphs.keys)
{
	NewPad("$\xi$");

	for (int rpi : rps.keys)
	{
		pen p = StdPen(rpi);
		if (rpi >= 1)
			p += dashed;

		draw(RootGetObject(f, rps[rpi] + "/" + graphs[gi]), "l", p, "RP " + rps[rpi]);
	}
}

frame f_legend = BuildLegend();

NewPad(false);
add(f_legend);
