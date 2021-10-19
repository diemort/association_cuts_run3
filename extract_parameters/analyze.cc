#include "TFile.h"
#include "TH2D.h"
#include "TF1.h"
#include "TGraph.h"

#include <TDirectory.h>
#include <cstdio>
#include <vector>
#include <string>
#include <map>

using namespace std;

//----------------------------------------------------------------------------------------------------

unsigned int GetNumberOfFitParameters(const string &q)
{
    if (q == "de_x_mean") return 2;
    if (q == "de_x_rms") return 2;

    if (q == "de_y_mean") return 2;
    if (q == "de_y_rms") return 2;

    return 0;
}

//----------------------------------------------------------------------------------------------------

string GetYNParametrisation(const string &q)
{
    if (q == "de_x_mean") return "[0] - [1]*abs(x)";
    if (q == "de_x_rms") return "[0] + [1]*x*x";
    //if (q == "de_y_mean") return "[0]*x";
    if (q == "de_y_mean") return "[0]*TMath::Erf(x/[1])";
    if (q == "de_y_rms") return "[0] + [1]*abs(x)";

    return "";
}

//----------------------------------------------------------------------------------------------------

vector<double> MakeYNFit(const string &q, TH1D *p)
{
    TF1 *ff = nullptr;
    vector<double> result;

    if (q == "de_x_mean")
    {
        ff = new TF1("ff", GetYNParametrisation(q).c_str());
        ff->SetParameters(-0.1, 0.2);
        p->Fit(ff, "Q", "");
        result.push_back(ff->GetParameter(0));
        result.push_back(ff->GetParameter(1));
        delete ff;
    }

    if (q == "de_x_rms")
    {
        ff = new TF1("ff", GetYNParametrisation(q).c_str());
        ff->SetParameters(0.1, 0.);
        p->Fit(ff, "WQ", "");
        result.push_back(ff->GetParameter(0));
        result.push_back(ff->GetParameter(1));
        delete ff;
    }

    if (q == "de_y_mean")
    {
        ff = new TF1("ff", GetYNParametrisation(q).c_str());
        ff->SetParameters(0.5, 2.);
        p->Fit(ff, "Q", "");
        result.push_back(ff->GetParameter(0));
        result.push_back(ff->GetParameter(1));
        delete ff;
    }

    if (q == "de_y_rms")
    {
        ff = new TF1("ff", GetYNParametrisation(q).c_str());
        ff->SetParameters(0.04, 0.004);
        p->Fit(ff, "Q", "", -4., +4.);
        result.push_back(ff->GetParameter(0));
        result.push_back(ff->GetParameter(1));
        delete ff;
    }

    return result;
}

//----------------------------------------------------------------------------------------------------

void ReplaceAll(string &s_full, const string &s_find, const string &s_repl)
{
    size_t idx = 0;
    while (true)
    {
        idx = s_full.find(s_find, idx);
        if (idx == string::npos)
            break;

        s_full.replace(idx, s_find.length(), s_repl);

        idx += s_repl.length();
    }
}

//----------------------------------------------------------------------------------------------------

string GetStringRepresentation(TF1 *f)
{
    string r = f->GetExpFormula().Data();
    for (int i = 0; i < f->GetNpar(); ++i)
    {
        const string par_tag = "[p" + to_string(i) + "]";
        const string par_val = to_string(f->GetParameter(i));
        ReplaceAll(r, par_tag, par_val);
    }

    ReplaceAll(r, "x", "[x_near]");

    return r;
}

//----------------------------------------------------------------------------------------------------

string MakeXNFit(const string &q, unsigned int pi, TGraph *g)
{
    TF1 *ff = nullptr;
    string result;

    if (q == "de_x_mean")
    {
        if (pi == 0)
        {
            ff = new TF1("ff", "[0] + [1]*x + [2]*x*x");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }

        if (pi == 1)
        {
            ff = new TF1("ff", "[0] + [1]/x");
            ff->SetParameters(0.1, 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }
    }

    if (q == "de_x_rms")
    {
        if (pi == 0)
        {
            ff = new TF1("ff", "[0] + [1]*x");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }

        if (pi == 1)
        {
            ff = new TF1("ff", "[0]");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }
    }

    if (q == "de_y_mean")
    {
        if (pi == 0)
        {
            ff = new TF1("ff", "[0] + [1]/x");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }

        if (pi == 1)
        {
            ff = new TF1("ff", "[0] + [1]*x");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }
    }

    if (q == "de_y_rms")
    {
        if (pi == 0)
        {
            ff = new TF1("ff", "[0] + [1]/x/x");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }

        if (pi == 1)
        {
            ff = new TF1("ff", "[0] + [1]/pow(x, 5)");
            ff->SetParameters(0., 0., 0.);
            g->Fit(ff, "Q", "");
            result = GetStringRepresentation(ff);
            delete ff;
        }
    }

    return result;
}

//----------------------------------------------------------------------------------------------------

int main()
{
    // settings
    vector<string> xangles = {
        "100",
        "130",
        "160",
    };

    string input_template = "simu/1E7/xangle_<xangle>/output_xy_distributions.root";

    const map<string, string> quantities = {
        {"de_x_mean", "p2_de_x_vs_x_y"},
        {"de_x_rms", "h2_rms_de_x_vs_x_y"},
        {"de_y_mean", "p2_de_y_vs_x_y"},
        {"de_y_rms", "h2_rms_de_y_vs_x_y"},
    };

    vector<string> arms = {
        "arm 0",
        "arm 1",
    };

    // prepare output
    TFile *f_out = TFile::Open("analyze.root", "recreate");

    // processing - loop over quantities
    for (const auto &arm : arms)
    {
        printf("\n==================== %s ====================\n", arm.c_str());

        TDirectory *d_arm = f_out->mkdir(arm.c_str());

        for (const auto &xangle : xangles)
        {
            printf("\n---------- xangle %s ----------\n", xangle.c_str());

            TDirectory *d_xangle = d_arm->mkdir(xangle.c_str());

            string fn_in = input_template;
            fn_in.replace(input_template.find("<xangle>"), 8, xangle);
            TFile *f_in = TFile::Open(fn_in.c_str());
            if (!f_in)
                continue;

            for (const auto &qi : quantities)
            {
                printf("* %s\n", qi.first.c_str());

                TDirectory *d_q = d_xangle->mkdir(qi.first.c_str());

                // get input
                TH2D *h2 = (TH2D *) f_in->Get((arm + "/" + qi.second).c_str());

                // prepare graphs
                const unsigned int n_params = GetNumberOfFitParameters(qi.first);
                vector<TGraph *> g_params(n_params);
                for (unsigned int i = 0; i < n_params; ++i)
                {
                    g_params[i] = new TGraph();
                    g_params[i]->SetTitle(";x_N");
                }

                // loop over slices
                //const double x_N_min = 2.75;
                const double x_N_min = 3.25;
				const double x_N_max = 11.75;
                const int bi_min = h2->GetXaxis()->FindBin(x_N_min);
                const int bi_max = h2->GetXaxis()->FindBin(x_N_max);

                TDirectory *d_slices = d_q->mkdir("slices");
                gDirectory = d_slices;

                for (int bi = bi_min; bi <= bi_max; ++bi)
                {
                    const double x_N_cen = h2->GetXaxis()->GetBinCenter(bi);

                    char buf[100];
                    sprintf(buf, "h_prof_%i_%.2f", bi, h2->GetXaxis()->GetBinCenter(bi));
                    TH1D *h_prof = h2->ProjectionY(buf, bi, bi);
                    h_prof->SetTitle(";y_N");

                    const auto &params = MakeYNFit(qi.first, h_prof);
                    h_prof->Write();

                    for (unsigned int i = 0; i < n_params; ++i)
                        g_params[i]->SetPoint(g_params[i]->GetN(), x_N_cen, params[i]);
                }

                // fit and save graphs
                string model = GetYNParametrisation(qi.first);
                ReplaceAll(model, "x", "[y_near]");

                gDirectory = d_q;
                for (unsigned int i = 0; i < n_params; ++i)
                {
                    const auto &par_string = MakeXNFit(qi.first, i, g_params[i]);
                    ReplaceAll(model, "[" + to_string(i) + "]", "(" + par_string + ")");

                    g_params[i]->Write(("g_param_" + to_string(i)).c_str());
                }

                printf("    model: %s\n", model.c_str());
            }

            delete f_in;
        }
    }

    // clean up
    delete f_out;

    return 0;
}
