import root;
import pad_layout;

string topDir = "../";

string f = topDir + "simu/default/1E5/output_xy_distributions.root";

string rp = "RP 103";

int rebin = 5;

//----------------------------------------------------------------------------------------------------

void DrawOne(RootObject h2, real x, pen p, string l)
{
	int bi = h2.oExec("GetXaxis").iExec("FindBin", x);
	RootObject prof = h2.oExec("ProjectionY", "bla", bi, bi);
	prof.vExec("Rebin", rebin);
	draw(prof, "vl,eb", p, l);
}

//----------------------------------------------------------------------------------------------------

RootObject hist = RootGetObject(f, rp + "/h2_de_y_vs_x");
//hist.vExec("Rebin2D", rebin_x, rebin_y);

NewPad("$\de y\ung{mm}$");
DrawOne(hist, 4., red, "$x \approx 4\un{mm}$");
DrawOne(hist, 6., blue, "$x \approx 6\un{mm}$");
DrawOne(hist, 10., heavygreen, "$x \approx 10\un{mm}$");
AttachLegend(BuildLegend(NW), NE);

real threshold = 4 * 0.06;
yaxis(XEquals(-threshold, false), dashed);
yaxis(XEquals(+threshold, false), dashed);
