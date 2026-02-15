---
name: performance
description: This skill should be used when the user asks to "optimize performance", "improve speed", "reduce memory usage", "fix memory leaks", "profile the app", "reduce load time", "improve scrolling", "reduce battery usage", or needs guidance on performance measurement, profiling tools, optimization techniques, and efficiency patterns for iOS and Android.
version: 1.0.0
---

# Performance Optimization Skill

Guide performance improvements through measurement, identification, and targeted optimization.

## Overview

Performance optimization follows a critical principle: **measure first, optimize second**. Never optimize without profiling—you might improve the wrong thing while missing actual bottlenecks.

## The Performance Optimization Loop

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  Measure    │ →  │  Identify   │ →  │  Optimize   │ →  │  Verify     │
│  Baseline   │    │  Bottleneck │    │  Targeted   │    │  Improvement│
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
       ↑                                                        │
       └────────────────────────────────────────────────────────┘
```

## Platform Profiling Tools

### iOS Instruments

| Instrument | Use Case |
|------------|----------|
| **Time Profiler** | CPU usage, hot functions |
| **Allocations** | Memory allocations, leaks |
| **Leaks** | Memory leak detection |
| **Network** | Network request timing |
| **Core Animation** | Frame rate, GPU issues |
| **Energy Log** | Battery impact |

### Android Profiler

| Profiler | Use Case |
|----------|----------|
| **CPU Profiler** | CPU usage, method traces |
| **Memory Profiler** | Allocations, leaks, heap |
| **Network Profiler** | Request timing, data transfer |
| **Energy Profiler** | Battery consumption |
| **Layout Inspector** | View hierarchy |

## Common Performance Issues

### Issue 1: Slow App Launch

**Symptoms**: Long splash screen, delayed first render

**Causes**:
- Heavy initialization on main thread
- Synchronous network calls
- Loading too much data upfront
- Complex first screen

**Solutions**:

```swift
// iOS: Defer heavy work
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Minimal setup only
        setupCriticalServices()

        // Defer non-critical work
        DispatchQueue.main.async {
            self.setupAnalytics()
            self.prefetchData()
        }
        return true
    }
}
```

```kotlin
// Android: Use App Startup library
class AppInitializer : Initializer<Unit> {
    override fun create(context: Context) {
        // Defer to background
        CoroutineScope(Dispatchers.Default).launch {
            setupAnalytics()
            prefetchData()
        }
    }

    override fun dependencies(): List<Class<out Initializer<*>>> = emptyList()
}
```

### Issue 2: Janky Scrolling

**Symptoms**: Dropped frames, stuttering lists

**Causes**:
- Complex cell layouts
- Image loading on main thread
- Excessive view creation
- Layout recalculation

**Solutions**:

```swift
// iOS: Reuse cells, async images
struct ContentView: View {
    var body: some View {
        List(items) { item in
            HStack {
                AsyncImage(url: item.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)

                Text(item.title)
            }
        }
    }
}
```

```kotlin
// Android: Use LazyColumn with keys
@Composable
fun ContentList(items: List<Item>) {
    LazyColumn {
        items(items, key = { it.id }) { item ->
            Row {
                AsyncImage(
                    model = item.imageUrl,
                    contentDescription = null,
                    modifier = Modifier.size(50.dp)
                )
                Text(item.title)
            }
        }
    }
}
```

### Issue 3: Memory Leaks

**Symptoms**: Growing memory, eventual crash

**Causes**:
- Strong reference cycles
- Retained closures/listeners
- Unreleased observers
- Context leaks (Android)

**Solutions**:

```swift
// iOS: Use weak references in closures
class ViewModel {
    var onUpdate: (() -> Void)?

    func fetchData() {
        api.fetch { [weak self] result in
            guard let self = self else { return }
            self.processResult(result)
            self.onUpdate?()
        }
    }
}
```

```kotlin
// Android: Use lifecycle-aware components
class MyViewModel : ViewModel() {
    private val _data = MutableStateFlow<Data?>(null)
    val data: StateFlow<Data?> = _data.asStateFlow()

    fun fetchData() {
        viewModelScope.launch {
            _data.value = repository.getData()
        }
    }
    // Automatically cancelled when ViewModel is cleared
}
```

### Issue 4: Slow Network Requests

**Symptoms**: Long loading times, timeouts

**Causes**:
- No caching
- Large payloads
- Sequential requests
- No pagination

**Solutions**:

```swift
// iOS: Implement caching
let cache = URLCache(
    memoryCapacity: 50_000_000,  // 50 MB
    diskCapacity: 100_000_000,   // 100 MB
    diskPath: "api_cache"
)

let config = URLSessionConfiguration.default
config.urlCache = cache
config.requestCachePolicy = .returnCacheDataElseLoad
```

```kotlin
// Android: Use OkHttp caching
val cache = Cache(
    directory = context.cacheDir.resolve("http_cache"),
    maxSize = 50L * 1024 * 1024 // 50 MB
)

val client = OkHttpClient.Builder()
    .cache(cache)
    .build()
```

### Issue 5: Battery Drain

**Symptoms**: User complaints, background energy usage

**Causes**:
- Frequent location updates
- Excessive background work
- Wake locks held too long
- Polling instead of push

**Solutions**:

```swift
// iOS: Use significant location changes
locationManager.startMonitoringSignificantLocationChanges()
// Instead of:
// locationManager.startUpdatingLocation()
```

```kotlin
// Android: Use WorkManager for background work
val workRequest = PeriodicWorkRequestBuilder<SyncWorker>(
    repeatInterval = 1,
    repeatIntervalTimeUnit = TimeUnit.HOURS
)
    .setConstraints(
        Constraints.Builder()
            .setRequiredNetworkType(NetworkType.CONNECTED)
            .setRequiresBatteryNotLow(true)
            .build()
    )
    .build()
```

## Optimization Patterns

### Pattern 1: Lazy Loading

Load resources only when needed:

```swift
// iOS: Lazy property
lazy var heavyObject: HeavyObject = {
    return HeavyObject()
}()
```

```kotlin
// Android: Lazy delegate
val heavyObject by lazy {
    HeavyObject()
}
```

### Pattern 2: Caching

Avoid redundant computation/fetching:

```swift
// iOS: NSCache for memory caching
let cache = NSCache<NSString, UIImage>()

func getImage(for key: String) -> UIImage? {
    if let cached = cache.object(forKey: key as NSString) {
        return cached
    }
    let image = loadImage(key)
    cache.setObject(image, forKey: key as NSString)
    return image
}
```

### Pattern 3: Debouncing

Reduce rapid successive calls:

```swift
// iOS: Combine debounce
searchText
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
    .sink { query in
        performSearch(query)
    }
```

```kotlin
// Android: Flow debounce
searchQuery
    .debounce(300)
    .collect { query ->
        performSearch(query)
    }
```

### Pattern 4: Pagination

Load data in chunks:

```swift
// iOS: Infinite scroll
func loadMore() {
    guard !isLoading, hasMore else { return }
    isLoading = true
    currentPage += 1
    Task {
        let newItems = try await api.fetch(page: currentPage)
        items.append(contentsOf: newItems)
        hasMore = !newItems.isEmpty
        isLoading = false
    }
}
```

## Performance Checklist

### Startup
- [ ] Defer non-critical initialization
- [ ] Avoid synchronous network calls
- [ ] Minimize first-screen complexity
- [ ] Use launch storyboard/splash properly

### Memory
- [ ] No strong reference cycles
- [ ] Proper observer cleanup
- [ ] Reasonable cache sizes
- [ ] Image downsampling

### UI
- [ ] 60fps scrolling (or 120fps on ProMotion)
- [ ] Cell reuse implemented
- [ ] Async image loading
- [ ] Minimal view hierarchy depth

### Network
- [ ] Request caching enabled
- [ ] Compression enabled
- [ ] Pagination implemented
- [ ] Parallel requests where appropriate

### Battery
- [ ] Background work minimized
- [ ] Location accuracy appropriate
- [ ] No unnecessary wake locks
- [ ] Push notifications over polling

## Quick Reference

### Measure Commands

```bash
# iOS - Build for profiling
xcodebuild -scheme MyApp -configuration Release build

# iOS - Open Instruments
open -a Instruments

# Android - Start profiler
adb shell am profile start <package> <output.trace>
```

### Key Metrics

| Metric | Good | Acceptable | Poor |
|--------|------|------------|------|
| App Launch | < 1s | 1-2s | > 2s |
| Frame Rate | 60 fps | 45-60 fps | < 45 fps |
| Memory (idle) | < 50 MB | 50-100 MB | > 100 MB |
| First Input Delay | < 100ms | 100-300ms | > 300ms |

## Additional Resources

- iOS: [WWDC Performance Videos](https://developer.apple.com/videos/)
- Android: [Android Performance Documentation](https://developer.android.com/topic/performance)
- Cross-platform: Review `skills/testing/SKILL.md` for performance testing
