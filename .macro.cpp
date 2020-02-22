#include <bits/stdc++.h>

using namespace std;

template <typename T>
using vec = vector<T>;
using ll = long long;
using str = string;
using pll = pair<ll, ll>;
using vll = vec<ll>;
using vpll = vec<pll>;
using vstr = vec<str>;

#define stdinout()                  \
  ios_base::sync_with_stdio(false); \
  cin.tie(0)
#define refile(f)                    \
  ifstream inFile(str(f) + ".in");   \
  ofstream outFile(str(f) + ".out"); \
  cin.rdbuf(inFile.rdbuf());         \
  cout.rdbuf(outFile.rdbuf())
#define au auto
#define defread(T, ...) \
  T __VA_ARGS__;        \
  in_read(__VA_ARGS__)
#define vecd(x, T, n) \
  vec<T> x;           \
  vecr(x, n)
#define lld(...) defread(ll, __VA_ARGS__)
#define strd(...) defread(str, __VA_ARGS__)
#define outp(p) cout << fixed << setprecision(p)
#define fori(i, a, b) for (ll i = a; i < b; ++i)
#define forr(i, v) for (au i = v.begin(); i != v.end(); ++i)
#define rofi(i, a, b) for (ll i = b - 1; i >= a; --i)
#define rofr(i, v) for (au i = v.rbegin(); i != v.end(); ++i)
#define pb push_back

#define OUT(x) cerr << (#x) << "@" << __LINE__ << "=" << x << "\n"
template <typename T>
void in_read(T& arg) {
  cin >> arg;
}
template <typename T, typename... ARGS>
void in_read(T& arg, ARGS&... args) {
  cin >> arg;
  in_read(args...);
}

template <typename T>
void vecr(vec<T>& arg, ll count) {
  T x;
  fori(i, 0, count) {
    cin >> x;
    arg.pb(x);
  }
}

template <typename FN>
ll bin_sea(ll lhs, ll rhs, FN checker) {
  while (lhs < rhs) {
    ll mid = (lhs + rhs + 1) / 2;
    if (checker(mid)) {
      lhs = mid;
    } else {
      rhs = mid - 1;
    }
  }
  return lhs;
}

int main() {
  // REMINDER: Use `stdinout()` or `refile("abc")`.

  // <VIM TEMPLATE START>
}
