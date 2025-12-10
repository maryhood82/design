import { useState, useEffect } from 'react';
import { BrowserRouter as Router, Routes, Route, Link, useLocation, useNavigate } from 'react-router-dom';
import './index.css';

function Header({ isAuthenticated, userRole }) {
  const location = useLocation();

  const getLinkClass = (path) => {
    const navLink = "text-gray-600 hover:text-gray-900 transition-colors duration-200 font-medium";
    const navLinkActive = "text-blue-600 font-bold transition-colors duration-200 border-b-2 border-blue-600";
    return location.pathname === path ? navLinkActive : navLink;
  };

  return (
    <header className="bg-white border-b border-gray-200 shadow-sm sticky top-0 z-50">
      <nav className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          <div className="flex items-center">
            <Link to="/" className="flex flex-col">
              <span className="text-2xl font-bold bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent leading-tight">
                News Curator
              </span>
              <span className="text-xs font-semibold text-gray-500 tracking-widest uppercase">
                AI Powered Analysis
              </span>
            </Link>
          </div>

          <div className="hidden md:flex md:items-center md:space-x-8">
            <Link to="/" className={getLinkClass("/")}>Home</Link>
            <Link to="/sources" className={getLinkClass("/sources")}>Sources</Link>
            <Link to="/articles" className={getLinkClass("/articles")}>Articles</Link>
            <Link to="/bias-chart" className={getLinkClass("/bias-chart")}>Bias Chart</Link>
            <Link to="/ai-analyzer" className={getLinkClass("/ai-analyzer")}>AI Analyzer</Link>
            {isAuthenticated && userRole === "superuser" && (
              <Link to="/users" className={getLinkClass("/users")}>Users</Link>
            )}
            {isAuthenticated && (
              <Link to="/profile" className={getLinkClass("/profile")}>Profile</Link>
            )}
          </div>

          {!isAuthenticated && (
            <Link
              to="/login"
              className="border-2 border-blue-600 text-blue-600 hover:bg-blue-600 hover:text-white font-semibold px-6 py-2 rounded-md transition-all duration-200"
            >
              Sign In
            </Link>
          )}
        </div>
      </nav>
    </header>
  );
}

function HomePage({ isAuthenticated, userRole }) {
  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="relative overflow-hidden">
          <div className="absolute inset-0 bg-gradient-to-br from-blue-500/5 via-white to-cyan-500/5" />
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-24 relative">
            <div className="text-center">
              <h1 className="text-6xl md:text-7xl font-bold text-gray-900 mb-6">
                Welcome to{' '}
                <span className="bg-gradient-to-r from-blue-600 to-cyan-600 bg-clip-text text-transparent">
                  News Curator
                </span>
              </h1>
              <p className="text-xl md:text-2xl text-gray-600 max-w-3xl mx-auto mb-12">
                Analyze news bias and credibility with AI-powered insights.
                Make informed decisions about the information you consume.
              </p>
              <div className="flex gap-4 justify-center flex-wrap">
                <Link
                  to="/ai-analyzer"
                  className="bg-gradient-to-r from-blue-600 to-cyan-600 hover:opacity-90 text-white font-bold px-8 py-4 rounded-full text-lg shadow-xl hover:shadow-2xl transform hover:scale-105 transition-all duration-200"
                >
                  Try AI Analyzer
                </Link>
                <Link
                  to="/articles"
                  className="bg-white text-gray-900 border-2 border-gray-200 hover:border-blue-500/50 font-bold px-8 py-4 rounded-full text-lg shadow-lg transition-all duration-200"
                >
                  Browse Articles
                </Link>
              </div>
            </div>
          </div>
        </div>

        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-200 border border-gray-100">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl font-bold text-white">S</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Track Sources</h3>
              <p className="text-gray-600">Monitor credibility across multiple news sources and build your trusted reading list.</p>
            </div>

            <div className="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-200 border border-gray-100">
              <div className="w-16 h-16 bg-gradient-to-br from-cyan-600 to-blue-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl font-bold text-white">B</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">Detect Bias</h3>
              <p className="text-gray-600">Identify political and ideological bias in articles automatically with AI analysis.</p>
            </div>

            <div className="bg-white rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow duration-200 border border-gray-100">
              <div className="w-16 h-16 bg-gradient-to-br from-blue-600 to-cyan-600 rounded-xl flex items-center justify-center mb-6">
                <span className="text-3xl font-bold text-white">AI</span>
              </div>
              <h3 className="text-2xl font-bold text-gray-900 mb-3">AI Analysis</h3>
              <p className="text-gray-600">Leverage GPT-4 for deep content analysis and misinformation detection.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

function SourcesPage({ isAuthenticated, userRole }) {
  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">News Sources</h1>
          <p className="text-xl text-gray-600 mb-8">Browse and manage your news sources here.</p>

          <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100">
            <p className="text-gray-500 text-center py-12">Source management coming soon...</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function ArticlesPage({ isAuthenticated, userRole }) {
  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">Articles</h1>
          <p className="text-xl text-gray-600 mb-8">View and analyze news articles.</p>

          <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100">
            <p className="text-gray-500 text-center py-12">Article list coming soon...</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function BiasChartPage({ isAuthenticated, userRole }) {
  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">Bias Chart</h1>
          <p className="text-xl text-gray-600 mb-8">Visualize media bias across different sources.</p>

          <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100">
            <p className="text-gray-500 text-center py-12">Bias visualization coming soon...</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function AIAnalyzerPage({ isAuthenticated, userRole }) {
  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <h1 className="text-5xl font-bold text-gray-900 mb-4">AI Analyzer</h1>
          <p className="text-xl text-gray-600 mb-8">Use AI to analyze article bias and credibility.</p>

          <div className="bg-white rounded-2xl p-8 shadow-lg border border-gray-100">
            <p className="text-gray-500 text-center py-12">AI analyzer coming soon...</p>
          </div>
        </div>
      </div>
    </div>
  );
}

function UsersPage({ isAuthenticated, userRole, userEmail }) {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    if (userEmail) {
      fetchUsers();
    }
  }, [userEmail]);

  const fetchUsers = async () => {
    setLoading(true);
    setError("");

    try {
      const response = await fetch("/walker/get_all_users", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ admin_email: userEmail })
      });

      const data = await response.json();

      if (data.success) {
        setUsers(data.users || []);
      } else {
        setError(data.message || "Failed to load users");
      }
    } catch (err) {
      setError("Network error. Please try again.");
    }

    setLoading(false);
  };

  return (
    <div>
      <Header isAuthenticated={isAuthenticated} userRole={userRole} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
          <div className="mb-8">
            <h1 className="text-5xl font-bold text-gray-900 mb-2">User Management</h1>
            <p className="text-xl text-gray-600">Manage user accounts, roles, and permissions</p>
          </div>

          {error && (
            <div className="mb-4 p-4 bg-red-50 border border-red-200 text-red-600 rounded-lg">
              {error}
            </div>
          )}

          <div className="bg-white rounded-2xl shadow-lg overflow-hidden border border-gray-100">
            {loading && (
              <div className="p-12 text-center">
                <div className="inline-block animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
                <p className="mt-4 text-gray-500">Loading users...</p>
              </div>
            )}
            {!loading && users.length === 0 && (
              <div className="p-12 text-center text-gray-500">
                No users found
              </div>
            )}
            {!loading && users.length > 0 && (
              <div className="overflow-x-auto">
                <table className="min-w-full divide-y divide-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">User</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Role</th>
                      <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                    </tr>
                  </thead>
                  <tbody className="bg-white divide-y divide-gray-200">
                    {users.map((user) => (
                      <tr key={user.email} className="hover:bg-gray-50">
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="text-sm font-medium text-gray-900">{user.name}</div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <div className="text-sm text-gray-900">{user.email}</div>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <span className="px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-100 text-blue-800">
                            {user.role}
                          </span>
                        </td>
                        <td className="px-6 py-4 whitespace-nowrap">
                          <span className={`px-3 py-1 inline-flex text-xs leading-5 font-semibold rounded-full ${
                            user.is_active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'
                          }`}>
                            {user.is_active ? "Active" : "Disabled"}
                          </span>
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  );
}

function ProfilePage({ user, logout }) {
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/');
  };

  if (!user) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50 flex items-center justify-center">
        <div className="text-center">
          <p className="text-xl text-gray-600 mb-4">Please log in to view your profile</p>
          <Link to="/login" className="text-blue-600 hover:text-blue-700 font-semibold">
            Go to Login
          </Link>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50">
      <div className="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="mb-8">
          <Link to="/" className="text-blue-600 hover:text-blue-700 flex items-center mb-4">
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Back to Home
          </Link>
          <h1 className="text-5xl font-bold text-gray-900">User Profile</h1>
          <p className="text-xl text-gray-600 mt-2">Manage your account settings</p>
        </div>

        <div className="bg-white rounded-2xl shadow-lg p-8">
          <div className="flex items-center space-x-4 mb-8">
            <div className="w-20 h-20 bg-gradient-to-r from-blue-600 to-cyan-600 rounded-full flex items-center justify-center text-3xl font-bold text-white">
              {user.name[0].toUpperCase()}
            </div>
            <div>
              <div className="text-2xl font-bold text-gray-900">{user.name}</div>
              <div className="text-gray-600">{user.email}</div>
              <span className={`inline-block mt-2 px-3 py-1 rounded-full text-sm font-semibold ${
                user.role === 'superuser' ? 'bg-purple-100 text-purple-800' :
                user.role === 'administrator' ? 'bg-blue-100 text-blue-800' :
                'bg-gray-100 text-gray-800'
              }`}>
                {user.role}
              </span>
            </div>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">
            <div className="border border-gray-200 rounded-lg p-4">
              <label className="text-sm font-medium text-gray-700 mb-1 block">Full Name</label>
              <p className="mt-1 text-lg text-gray-900">{user.name}</p>
            </div>
            <div className="border border-gray-200 rounded-lg p-4">
              <label className="text-sm font-medium text-gray-700 mb-1 block">Email Address</label>
              <p className="mt-1 text-lg text-gray-900">{user.email}</p>
            </div>
            <div className="border border-gray-200 rounded-lg p-4">
              <label className="text-sm font-medium text-gray-700 mb-1 block">Account Role</label>
              <p className="mt-1 text-lg text-gray-900">{user.role}</p>
            </div>
            <div className="border border-gray-200 rounded-lg p-4">
              <label className="text-sm font-medium text-gray-700 mb-1 block">Member Since</label>
              <p className="mt-1 text-lg text-gray-900">{user.created_at || 'N/A'}</p>
            </div>
          </div>

          <div className="pt-6 border-t border-gray-200">
            <button
              onClick={handleLogout}
              className="bg-red-600 hover:bg-red-700 text-white font-semibold px-6 py-3 rounded-lg transition-all duration-200"
            >
              Logout
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

function LoginPage({ onLogin }) {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError("");
    setLoading(true);

    const result = await onLogin(username, password);
    setLoading(false);

    if (result.success) {
      window.location.href = '/';
    } else {
      setError(result.error || "Login failed");
    }
  };

  return (
    <div>
      <Header isAuthenticated={false} userRole={""} />
      <div className="min-h-screen bg-gradient-to-br from-slate-50 to-blue-50 flex items-center justify-center">
        <div className="bg-white rounded-2xl shadow-lg p-8 w-full max-w-md">
          <Link to="/" className="text-blue-600 hover:text-blue-700 flex items-center mb-4">
            <svg className="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10 19l-7-7m0 0l7-7m-7 7h18" />
            </svg>
            Back to Home
          </Link>
          <h2 className="text-3xl font-bold text-gray-900 mb-2">Welcome Back</h2>
          <p className="text-gray-600 mb-6">Sign in to your News Curator account</p>
          {error && <div className="mb-4 p-3 bg-red-50 border border-red-200 text-red-600 rounded-lg text-sm">{error}</div>}
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Username</label>
              <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Enter your username"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">Password</label>
              <input
                type="password"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent"
                placeholder="Enter your password"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full bg-gradient-to-r from-blue-600 to-cyan-600 hover:from-blue-700 hover:to-cyan-700 text-white font-bold py-3 px-4 rounded-lg transition-all duration-200 disabled:opacity-50"
              disabled={loading}
            >
              {loading ? "Signing in..." : "Sign In"}
            </button>
          </form>
        </div>
      </div>
    </div>
  );
}

function App() {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [user, setUser] = useState(null);
  const [userRole, setUserRole] = useState("");

  const handleLogin = async (username, password) => {
    try {
      const response = await fetch("http://localhost:8000/walker/login_user", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: username + "@news.com", password: password })
      });
      const data = await response.json();

      if (data.reports && data.reports[0] && data.reports[0].success) {
        setIsAuthenticated(true);
        setUser(data.reports[0].user);
        setUserRole(data.reports[0].user.role);
        return { success: true };
      } else {
        const errorMessage = data.reports && data.reports[0] ? data.reports[0].message : "Login failed";
        return { success: false, error: errorMessage };
      }
    } catch (err) {
      return { success: false, error: "Network error" };
    }
  };

  const handleLogout = () => {
    setIsAuthenticated(false);
    setUser(null);
    setUserRole("");
  };

  return (
    <Router>
      <Routes>
        <Route path="/" element={<HomePage isAuthenticated={isAuthenticated} userRole={userRole} />} />
        <Route path="/sources" element={<SourcesPage isAuthenticated={isAuthenticated} userRole={userRole} />} />
        <Route path="/articles" element={<ArticlesPage isAuthenticated={isAuthenticated} userRole={userRole} />} />
        <Route path="/bias-chart" element={<BiasChartPage isAuthenticated={isAuthenticated} userRole={userRole} />} />
        <Route path="/ai-analyzer" element={<AIAnalyzerPage isAuthenticated={isAuthenticated} userRole={userRole} />} />
        <Route path="/users" element={<UsersPage isAuthenticated={isAuthenticated} userRole={userRole} userEmail={user?.email || ""} />} />
        <Route path="/profile" element={<ProfilePage user={user} logout={handleLogout} />} />
        <Route path="/login" element={<LoginPage onLogin={handleLogin} />} />
      </Routes>
    </Router>
  );
}

export default App;
