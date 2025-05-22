import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/task_service.dart';
import 'models/user_model.dart';
import 'models/task_model.dart';

// Custom color scheme
class AppColors {
  static const primaryPurple = Color(0xFF6B4EFF);
  static const lightPurple = Color(0xFFE8E4FF);
  static const darkPurple = Color(0xFF4A3D99);
  static const accentPink = Color(0xFFFF6B9C);
  static const backgroundWhite = Color(0xFFF8F9FF);
  static const textDark = Color(0xFF2D3142);
  static const textLight = Color(0xFF9C9EB9);
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TaskService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee & Intern Management',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryPurple,
          secondary: AppColors.accentPink,
          background: AppColors.backgroundWhite,
          surface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: AppColors.textDark,
          onSurface: AppColors.textDark,
        ),
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryPurple,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightPurple),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.lightPurple),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                const BorderSide(color: AppColors.primaryPurple, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.textLight),
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/directory': (context) => const DirectoryPage(),
        '/add_edit_profile': (context) => const AddEditProfilePage(),
        '/profile_detail': (context) => const ProfileDetailPage(),
        '/tasks': (context) => const TaskManagementPage(),
        '/attendance': (context) => const AttendancePage(),
        '/performance': (context) => const PerformanceReviewPage(),
        '/chat': (context) => const ChatPage(),
        '/settings': (context) => const SettingsPage(),
        '/admin': (context) => const AdminPanelPage(),
      },
    );
  }
}

// Login/Signup Page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryPurple,
              AppColors.darkPurple,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.work_outline,
                                size: 64,
                                color: AppColors.primaryPurple,
                              ),
                              const SizedBox(height: 24),
                              const Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 24),
                              TextFormField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              if (authService.error != null)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(
                                    authService.error!,
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: authService.isLoading
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            final success =
                                                await authService.login(
                                              _emailController.text,
                                              _passwordController.text,
                                            );
                                            if (success) {
                                              Navigator.pushReplacementNamed(
                                                  context, '/dashboard');
                                            }
                                          }
                                        },
                                  child: authService.isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : const Text('Login'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  // Show sign up dialog
                                  showDialog(
                                    context: context,
                                    builder: (context) => const SignUpDialog(),
                                  );
                                },
                                child: const Text(
                                    'Don\'t have an account? Sign Up'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({super.key});

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _departmentController = TextEditingController();
  UserRole _selectedRole = UserRole.employee;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _departmentController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your department';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<UserRole>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  prefixIcon: Icon(Icons.work),
                ),
                items: UserRole.values.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedRole = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              if (authService.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    authService.error!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authService.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await authService.signUp(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              department: _departmentController.text,
                              role: _selectedRole,
                            );
                            if (success) {
                              Navigator.pop(context); // Close dialog
                              Navigator.pushReplacementNamed(
                                  context, '/dashboard');
                            }
                          }
                        },
                  child: authService.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dashboard Page (Role-Based)
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Summary Cards (now horizontally scrollable)
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _SummaryCard(title: 'Employees', value: '12'),
                  const SizedBox(width: 12),
                  _SummaryCard(title: 'Interns', value: '5'),
                  const SizedBox(width: 12),
                  _SummaryCard(title: 'Tasks', value: '23'),
                  const SizedBox(width: 12),
                  _SummaryCard(title: 'Attendance', value: '92%'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Quick Actions
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                SizedBox(
                  width: 160,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.person_add),
                    label: const Text('Add User'),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/add_edit_profile'),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.assignment),
                    label: const Text('Assign Task'),
                    onPressed: () => Navigator.pushNamed(context, '/tasks'),
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.bar_chart),
                    label: const Text('View Reports'),
                    onPressed: () => Navigator.pushNamed(context, '/admin'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Directory shortcut
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Employee & Intern Directory'),
              onTap: () => Navigator.pushNamed(context, '/directory'),
            ),
          ],
        ),
      ),
      drawer: _AppDrawer(),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  const _SummaryCard({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryPurple, AppColors.darkPurple],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Directory Page
class DirectoryPage extends StatelessWidget {
  const DirectoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Dummy data
    final profiles = [
      {'name': 'Alice', 'role': 'Employee', 'status': 'Active'},
      {'name': 'Bob', 'role': 'Intern', 'status': 'Inactive'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Directory')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: 'Search'),
              ),
            ),
            ...profiles.map(
              (p) => Card(
                child: ListTile(
                  title: Text(p['name']!),
                  subtitle: Text('${p['role']} - ${p['status']}'),
                  onTap: () => Navigator.pushNamed(context, '/profile_detail'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        Navigator.pushNamed(context, '/add_edit_profile'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Profile'),
                  onPressed: () =>
                      Navigator.pushNamed(context, '/add_edit_profile'),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: _AppDrawer(),
    );
  }
}

// Add/Edit Employee or Intern Page
class AddEditProfilePage extends StatelessWidget {
  const AddEditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Edit Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Phone')),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Role'),
              items: ['Employee', 'Intern']
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(labelText: 'Join Date'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Contract Type'),
              items: ['Full-Time', 'Part-Time', 'Internship']
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Status'),
              items: ['Active', 'Inactive']
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Detailed Profile Page with Tabs
class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile Detail'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Tasks'),
              Tab(text: 'Attendance'),
              Tab(text: 'Feedback'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Overview Info')),
            Center(child: Text('Tasks List')),
            Center(child: Text('Attendance History')),
            Center(child: Text('Performance Feedback')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.message),
          tooltip: 'Message',
        ),
        drawer: _AppDrawer(),
      ),
    );
  }
}

// Task Management Page (Kanban-style)
class TaskManagementPage extends StatelessWidget {
  const TaskManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    // Load demo tasks if empty
    if (taskService.tasks.isEmpty) {
      taskService.loadDemoTasks();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
        ],
      ),
      // Fix overflow by wrapping Row in SingleChildScrollView with horizontal scroll
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            // Set a max width to avoid infinite width
            maxWidth: 1000,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 320,
                child: _KanbanColumn(
                  title: 'To Do',
                  tasks: taskService.getTasksByStatus(TaskStatus.todo),
                  onTaskTap: (task) => _showTaskDetails(context, task),
                ),
              ),
              SizedBox(
                width: 320,
                child: _KanbanColumn(
                  title: 'In Progress',
                  tasks: taskService.getTasksByStatus(TaskStatus.inProgress),
                  onTaskTap: (task) => _showTaskDetails(context, task),
                ),
              ),
              SizedBox(
                width: 320,
                child: _KanbanColumn(
                  title: 'Done',
                  tasks: taskService.getTasksByStatus(TaskStatus.done),
                  onTaskTap: (task) => _showTaskDetails(context, task),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddTaskDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
      drawer: _AppDrawer(),
    );
  }

  void _showTaskDetails(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    _TaskDetailItem(
                      icon: Icons.description,
                      title: 'Description',
                      content: task.description,
                    ),
                    _TaskDetailItem(
                      icon: Icons.calendar_today,
                      title: 'Due Date',
                      content: task.dueDate.toString(),
                    ),
                    _TaskDetailItem(
                      icon: Icons.priority_high,
                      title: 'Priority',
                      content: task.priority.toString().split('.').last,
                    ),
                    if (task.comments != null && task.comments!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Comments',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ...task.comments!.map(
                            (comment) => Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.person),
                                ),
                                title: Text(comment),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Add comment
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTaskDialog(),
    );
  }
}

class _KanbanColumn extends StatelessWidget {
  final String title;
  final List<Task> tasks;
  final Function(Task) onTaskTap;

  const _KanbanColumn({
    required this.title,
    required this.tasks,
    required this.onTaskTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightPurple),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: AppColors.primaryPurple,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tasks.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: tasks.isEmpty
                    ? const Center(
                        child: Text(
                          'No tasks',
                          style: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return ListTile(
                            title: Text(task.title),
                            onTap: () => onTaskTap(task),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskDetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;

  const _TaskDetailItem({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primaryPurple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  TaskPriority _priority = TaskPriority.medium;
  String _assignedTo = '1'; // Default to first user

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskService = Provider.of<TaskService>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Create New Task',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Due Date'),
                subtitle: Text(_dueDate.toString().split(' ')[0]),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      _dueDate = date;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TaskPriority>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  prefixIcon: Icon(Icons.priority_high),
                ),
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _priority = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: taskService.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            final task = Task(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              title: _titleController.text,
                              description: _descriptionController.text,
                              assignedTo: _assignedTo,
                              assignedBy: '1', // Current user
                              dueDate: _dueDate,
                              createdAt: DateTime.now(),
                              status: TaskStatus.todo,
                              priority: _priority,
                            );

                            final success = await taskService.addTask(task);
                            if (success) {
                              Navigator.pop(context);
                            }
                          }
                        },
                  child: taskService.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Create Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Attendance Page
class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {}, child: const Text('Check In')),
          ElevatedButton(onPressed: () {}, child: const Text('Check Out')),
          const SizedBox(height: 16),
          const Text('Daily Summary: Present: 10, Absent: 2, Late: 1'),
        ],
      ),
      drawer: _AppDrawer(),
    );
  }
}

// Performance Review Page
class PerformanceReviewPage extends StatelessWidget {
  const PerformanceReviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Review')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: const InputDecoration(labelText: 'Reviewer')),
            const SizedBox(height: 12),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Rating'),
              items: [1, 2, 3, 4, 5]
                  .map((r) => DropdownMenuItem(value: r, child: Text('$r')))
                  .toList(),
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Comments')),
            const SizedBox(height: 12),
            TextField(decoration: const InputDecoration(labelText: 'Date')),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit Feedback'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Progress Reports (Downloadable PDF coming soon)'),
          ],
        ),
      ),
      drawer: _AppDrawer(),
    );
  }
}

// Chat / Messaging Page (Optional MVP)
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat / Messaging')),
      body: const Center(child: Text('Chat UI Coming Soon')),
      drawer: _AppDrawer(),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Notifications'),
            value: true,
            onChanged: (_) {},
          ),
          ListTile(title: const Text('Change Password'), onTap: () {}),
          ListTile(title: const Text('Theme Settings'), onTap: () {}),
          ListTile(
            title: const Text('Role Management (Admin Only)'),
            onTap: () {},
          ),
        ],
      ),
      drawer: _AppDrawer(),
    );
  }
}

// Admin Control Panel
class AdminPanelPage extends StatelessWidget {
  const AdminPanelPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Control Panel')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Overall Stats:'),
            const SizedBox(height: 8),
            const Text('Employees: 12, Interns: 5, Tasks: 23'),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Generate PDF Report'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Export CSV'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Add/Remove Roles'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Backup & Restore'),
              ),
            ),
          ],
        ),
      ),
      drawer: _AppDrawer(),
    );
  }
}

// Drawer for navigation
class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primaryPurple, AppColors.darkPurple],
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.dashboard,
              title: 'Dashboard',
              route: '/dashboard',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.people,
              title: 'Directory',
              route: '/directory',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.assignment,
              title: 'Tasks',
              route: '/tasks',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.calendar_today,
              title: 'Attendance',
              route: '/attendance',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.assessment,
              title: 'Performance',
              route: '/performance',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.chat,
              title: 'Chat',
              route: '/chat',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.settings,
              title: 'Settings',
              route: '/settings',
            ),
            _buildDrawerItem(
              context,
              icon: Icons.admin_panel_settings,
              title: 'Admin Panel',
              route: '/admin',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: () => Navigator.pushReplacementNamed(context, route),
      hoverColor: Colors.white.withOpacity(0.1),
    );
  }
}
