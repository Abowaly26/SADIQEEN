import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/categories_cubit/categories_state.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:sadiqeen/features/home/logic/sub_categories_cubit/sub_categories_state.dart';
import 'package:sadiqeen/features/home/view/widgets/filter_button.dart';
import 'package:sadiqeen/features/home/view/widgets/service_card.dart';
import 'package:sadiqeen/features/home/data/models/categories_response_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int? selectedFilter;
  final TextEditingController _searchController = TextEditingController();
  bool _isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _selectFirstCategory(List<Category> categories) {
    if (_isFirstLoad && categories.isNotEmpty) {
      _isFirstLoad = false;
      final firstCategory = categories[0];
      
      // استخدام WidgetsBinding لتأخير التنفيذ حتى بعد اكتمال البناء
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            selectedFilter = firstCategory.id;
          });
          context
              .read<SubCategoriesCubit>()
              .fetchSubCategories(firstCategory.id);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: const Text(
                    'الخدمات',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchController,
                  textDirection: TextDirection.rtl,
                  enabled: selectedFilter != null,
                  onChanged: (value) {
                    if (selectedFilter != null) {
                      try {
                        context.read<SubCategoriesCubit>().fetchSubCategories(
                          selectedFilter!,
                          search: value.trim().isEmpty ? null : value.trim(),
                        );
                      } catch (e) {
                        debugPrint('Search error: $e');
                      }
                    }
                  },
                  decoration: InputDecoration(
                    hintText: selectedFilter == null
                        ? 'اختر فئة أولاً للبحث ...'
                        : 'ابحث باسم الخدمة ...',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    filled: true,
                    fillColor: selectedFilter == null
                        ? Colors.grey[200]
                        : Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Buttons
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  List<Category> categories = [];

                  state.maybeWhen(
                    success: (data) {
                      categories = data;
                      // تحديد أول فئة تلقائياً
                      _selectFirstCategory(categories);
                    },
                    orElse: () {},
                  );

                  if (categories.isEmpty) {
                    return const SizedBox(
                      height: 60,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  return Container(
                    color: Colors.white,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(categories.length, (index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: FilterButton(
                              title: category.name,
                              icon: category.icon,
                              isSelected: selectedFilter == category.id,
                              onTap: () {
                                setState(() {
                                  selectedFilter = category.id;
                                  _searchController.clear();
                                });
                                context
                                    .read<SubCategoriesCubit>()
                                    .fetchSubCategories(category.id);
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),

              // Services Grid
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<SubCategoriesCubit, SubCategoriesState>(
                    builder: (context, state) {
                      return state.when(
                        initial: () => const Center(
                          child: Text(
                            'اختر فئة لعرض الخدمات',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        success: (services) {
                          final list = services.data ?? [];

                          if (list.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    _searchController.text.isEmpty
                                        ? 'لا توجد خدمات'
                                        : 'لا توجد نتائج للبحث',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.0,
                                ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final service = list[index];
                              // تجاهل العناصر اللي مفيهاش بيانات
                              if (service.id == null ||
                                  service.name == null ||
                                  service.name!.isEmpty) {
                                return const SizedBox.shrink();
                              }
                              return ServiceCard(
                                image: service.icon ?? "",
                                title: service.name ?? "غير معروف",
                                color: Colors.blue,
                              );
                            },
                          );
                        },
                        error: (message) => Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                message ?? 'حدث خطأ',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(
                                    255,
                                    255,
                                    212,
                                    111,
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  if (selectedFilter != null) {
                                    _searchController.clear();
                                    context
                                        .read<SubCategoriesCubit>()
                                        .fetchSubCategories(selectedFilter!);
                                  }
                                },
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}