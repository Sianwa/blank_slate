#!/bin/bash

echo -e "${CYAN}"
cat << "EOF"

██████╗ ██╗      █████╗ ███╗   ██╗██╗  ██╗      ███████╗██╗      █████╗ ████████╗███████╗
██╔══██╗██║     ██╔══██╗████╗  ██║██║ ██╔╝      ██╔════╝██║     ██╔══██╗╚══██╔══╝██╔════╝
██████╔╝██║     ███████║██╔██╗ ██║█████╔╝       ███████╗██║     ███████║   ██║   █████╗
██╔══██╗██║     ██╔══██║██║╚██╗██║██╔═██╗       ╚════██║██║     ██╔══██║   ██║   ██╔══╝
██████╔╝███████╗██║  ██║██║ ╚████║██║  ██╗      ███████║███████╗██║  ██║   ██║   ███████╗
╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝      ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝

EOF
echo -e "${NC}"

#!/bin/bash
set -euo pipefail

### ---------- Constants ---------- ###
IOS_PLIST_PATH="ios/Runner/Info.plist"
PBXPROJ_PATH="ios/Runner.xcodeproj/project.pbxproj"
BUILD_GRADLE_PATH="android/app/build.gradle.kts"
PUBSPEC_PATH="pubspec.yaml"

### ---------- Platform Detection ---------- ###
function detect_platform() {
    case "$(uname -s)" in
        Darwin*)    PLATFORM="mac" ;;
        CYGWIN*|MINGW*|MSYS*) PLATFORM="windows" ;;
        Linux*)     PLATFORM="linux" ;;
        *)          PLATFORM="unknown" ;;
    esac

    if [[ "$PLATFORM" == "unknown" ]]; then
        echo "❌ ERROR: Unsupported platform. This script supports macOS, Windows (Git Bash/WSL), and Linux."
        exit 1
    fi
}

### ---------- Helper Functions ---------- ###
function print_info() { echo "ℹ️  $1"; }
function print_success() { echo "✅ $1"; }
function print_error() { echo "❌ ERROR: $1"; }

function validate_prerequisites() {
    local required_tools=("flutter" "sed" "find" "grep")
    local missing_tools=()

    for tool in "${required_tools[@]}"; do
        if ! command -v "$tool" &> /dev/null; then
            missing_tools+=("$tool")
        fi
    done

    if [[ ${#missing_tools[@]} -ne 0 ]]; then
        print_error "Missing required tools: ${missing_tools[*]}"
        print_info "Please install the missing tools and try again."
        exit 1
    fi
}

function validate_flutter_project() {
    if [[ ! -f "$PUBSPEC_PATH" ]]; then
        print_error "Not a Flutter project (pubspec.yaml not found)"
        exit 1
    fi

    if [[ ! -f "$BUILD_GRADLE_PATH" ]]; then
        print_error "Android configuration not found ($BUILD_GRADLE_PATH)"
        exit 1
    fi

    if [[ ! -d "android" ]] || [[ ! -d "ios" ]]; then
        print_error "Missing Android or iOS directories"
        exit 1
    fi
}

function get_user_input() {
    if [[ -z "${APP_NAME:-}" ]]; then
        read -p "📱 Enter app name: " APP_NAME
    fi

    if [[ -z "${PACKAGE_ID:-}" ]]; then
        read -p "📦 Enter package ID (e.g., com.company.app): " PACKAGE_ID
    fi
}

function validate_input() {
    if [[ -z "${APP_NAME:-}" || -z "${PACKAGE_ID:-}" ]]; then
        print_error "APP_NAME and PACKAGE_ID are required"
        exit 1
    fi

    # More flexible package ID validation
    if ! [[ "$PACKAGE_ID" =~ ^[a-z][a-z0-9_]*(\.[a-z][a-z0-9_]*)+$ ]]; then
        print_error "PACKAGE_ID must follow reverse domain format (e.g., com.example.app)"
        print_info "Use lowercase letters, numbers, and underscores only"
        exit 1
    fi

    # Validate app name doesn't contain problematic characters
    if [[ "$APP_NAME" =~ [\"\'\\] ]]; then
        print_error "APP_NAME cannot contain quotes or backslashes"
        exit 1
    fi
}

function create_backup() {
    local backup_dir=".flutter_setup_backup_$(date +%Y%m%d_%H%M%S)"
    print_info "Creating backup in $backup_dir..."

    mkdir -p "$backup_dir"

    # Backup critical files
    [[ -f "$PUBSPEC_PATH" ]] && cp "$PUBSPEC_PATH" "$backup_dir/"
    [[ -f "$BUILD_GRADLE_PATH" ]] && cp "$BUILD_GRADLE_PATH" "$backup_dir/"
    [[ -f "$IOS_PLIST_PATH" ]] && cp "$IOS_PLIST_PATH" "$backup_dir/"
    [[ -f "$PBXPROJ_PATH" ]] && cp "$PBXPROJ_PATH" "$backup_dir/"

    echo "$backup_dir" > .last_flutter_backup
    print_success "Backup created"
}

function cross_platform_sed() {
    local pattern="$1"
    local file="$2"

    # Create backup and apply changes
    if [[ "$PLATFORM" == "mac" ]]; then
        sed -i.bak "$pattern" "$file"
    else
        sed -i.bak "$pattern" "$file"
    fi

    # Remove backup file
    rm -f "${file}.bak"
}

function extract_old_package_id() {
    if [[ ! -f "$BUILD_GRADLE_PATH" ]]; then
        print_error "Build gradle not found: $BUILD_GRADLE_PATH"
        exit 1
    fi

    OLD_PACKAGE_ID=$(sed -nE 's/^[[:space:]]*applicationId[[:space:]]*=?[[:space:]]*["'\'']([^"'\'';]+)["'\''].*/\1/p' "$BUILD_GRADLE_PATH" | head -1)
    #OLD_PACKAGE_ID=$(sed -n 's/.*applicationId[[:space:]]*["\047]\([^"'\'']*\)["\047].*/\1/p' "$BUILD_GRADLE_PATH" | head -1)

    if [[ -z "$OLD_PACKAGE_ID" ]]; then
        print_error "Could not extract current Android package ID from $BUILD_GRADLE_PATH"
        exit 1
    fi

    print_info "Current package ID: $OLD_PACKAGE_ID"
}

function rename_flutter_app() {
    print_info "Renaming Flutter app to \"$APP_NAME\"..."

    # Sanitize app name for pubspec.yaml (must be valid Dart package name)
    local sanitized_name=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/_/g' | sed 's/_\+/_/g' | sed 's/^_\|_$//g')

    if [[ -z "$sanitized_name" ]]; then
        print_error "Could not create valid package name from app name"
        exit 1
    fi

    cross_platform_sed "s/^name:.*/name: $sanitized_name/" "$PUBSPEC_PATH"
    print_success "Updated pubspec.yaml"
}

function reinit_git(){
  # Initialize Git repository
  print_info "Creating Git repo ...."
  rm -rf .git
  git init
}

function update_android_package() {
    print_info "Updating Android package from $OLD_PACKAGE_ID to $PACKAGE_ID..."

    # Update build.gradle
    cross_platform_sed "s/applicationId[[:space:]]*=[[:space:]]*\"${OLD_PACKAGE_ID}\"/applicationId = \"${PACKAGE_ID}\"/" "$BUILD_GRADLE_PATH"
    cross_platform_sed "s/namespace[[:space:]]*=[[:space:]]*\"${OLD_PACKAGE_ID}\"/namespace = \"${PACKAGE_ID}\"/" "$BUILD_GRADLE_PATH"


    # Update all Android files containing the old package name
    if find android -type f \( -name "*.xml" -o -name "*.gradle" -o -name "*.java" -o -name "*.kt" \) -print0 2>/dev/null | xargs -0 grep -l "$OLD_PACKAGE_ID" 2>/dev/null; then
        find android -type f \( -name "*.xml" -o -name "*.gradle" -o -name "*.java" -o -name "*.kt" \) -print0 | xargs -0 sed -i.bak "s/${OLD_PACKAGE_ID}/${PACKAGE_ID}/g"
        find android -name "*.bak" -type f -delete 2>/dev/null || true
    fi

    # Update app label in AndroidManifest.xml
    local manifest="android/app/src/main/AndroidManifest.xml"
    if [[ -f "$manifest" ]]; then
        cross_platform_sed "s/android:label=\"[^\"]*\"/android:label=\"${APP_NAME}\"/" "$manifest"
    fi

    print_success "Updated Android configuration"
}

function move_android_package_structure() {
    print_info "Moving Android package directory structure..."

    local old_path=$(echo "$OLD_PACKAGE_ID" | tr '.' '/')
    local new_path=$(echo "$PACKAGE_ID" | tr '.' '/')

    # Handle both Java and Kotlin directories
    for lang_dir in "java" "kotlin"; do
        local src_base="android/app/src/main/$lang_dir"
        local old_full_path="$src_base/$old_path"
        local new_full_path="$src_base/$new_path"

        if [[ -d "$old_full_path" ]]; then
            print_info "Moving $lang_dir package structure..."

            # Create new directory structure
            mkdir -p "$new_full_path"

            print_info "Old directory path :: $old_full_path ....................."
            print_info "New directory path :: $new_full_path ....................."

            # Capture the first found content into a variable
            local first_found_item=$(find "$old_full_path" -mindepth 1 -print -quit 2>/dev/null)

            if [[ -n "$first_found_item" ]]; then
                print_info "Found content in '$old_full_path'. Proceeding to move files/subdirectories."
                # Print the first item found for debugging
                print_info "First item found by 'find': $first_found_item"

                # Move all contents (files and subdirectories) from the old final package directory
                # into the newly created final package directory.
                mv "$old_full_path"/* "$new_full_path/" 2>/dev/null || true
            else
                print_info "No files or subdirectories found directly within '$old_full_path'. Skipping file/directory move for this path."
            fi

            # Clean up old empty directories
            local cleanup_path="$old_full_path"
            while [[ "$cleanup_path" != "$src_base" ]] && [[ -d "$cleanup_path" ]]; do
                if [[ -z "$(find "$cleanup_path" -mindepth 1 2>/dev/null)" ]]; then
                    rmdir "$cleanup_path" 2>/dev/null || break
                    cleanup_path=$(dirname "$cleanup_path")
                else
                    break
                fi
            done

        fi
    done

    print_success "Moved Android package structure"
}

function update_ios_bundle_id() {
    print_info "Updating iOS bundle ID..."

    # Update Info.plist
    if [[ -f "$IOS_PLIST_PATH" ]]; then
        if command -v plutil &> /dev/null && [[ "$PLATFORM" == "mac" ]]; then
            # Use plutil on macOS
            plutil -replace CFBundleIdentifier -string "$PACKAGE_ID" "$IOS_PLIST_PATH"
            plutil -replace CFBundleName -string "$APP_NAME" "$IOS_PLIST_PATH" 2>/dev/null || true
            plutil -replace CFBundleDisplayName -string "$APP_NAME" "$IOS_PLIST_PATH" 2>/dev/null || true
        else
            # Fallback to sed for other platforms
            cross_platform_sed "/<key>CFBundleIdentifier<\/key>/,/<\/string>/ s/<string>.*<\/string>/<string>$PACKAGE_ID<\/string>/" "$IOS_PLIST_PATH"
            cross_platform_sed "/<key>CFBundleName<\/key>/,/<\/string>/ s/<string>.*<\/string>/<string>$APP_NAME<\/string>/" "$IOS_PLIST_PATH"
            cross_platform_sed "/<key>CFBundleDisplayName<\/key>/,/<\/string>/ s/<string>.*<\/string>/<string>$APP_NAME<\/string>/" "$IOS_PLIST_PATH"
        fi
        print_success "Updated Info.plist"
    fi

    # Update project.pbxproj
    if [[ -f "$PBXPROJ_PATH" ]]; then
        cross_platform_sed "s/PRODUCT_BUNDLE_IDENTIFIER = [^;]*/PRODUCT_BUNDLE_IDENTIFIER = $PACKAGE_ID/g" "$PBXPROJ_PATH"
        # Also update any old package ID references
        cross_platform_sed "s/${OLD_PACKAGE_ID}/${PACKAGE_ID}/g" "$PBXPROJ_PATH"
        print_success "Updated project.pbxproj"
    fi
}

function flutter_cleanup() {
    print_info "Running flutter clean & pub get..."

    if ! flutter clean; then
        print_error "Flutter clean failed"
        exit 1
    fi

    if ! flutter pub get; then
        print_error "Flutter pub get failed"
        exit 1
    fi

    print_success "Flutter cleanup completed"
}

function success_message() {
    echo ""
    print_success "Project configuration complete!"
    echo "👉 App Name: $APP_NAME"
    echo "👉 Package ID: $OLD_PACKAGE_ID → $PACKAGE_ID"
    echo "👉 Platform: $PLATFORM"

    if [[ -f ".last_flutter_backup" ]]; then
        echo "👉 Backup: $(cat .last_flutter_backup)"
    fi

    echo ""
    print_info "Next steps:"
    echo "  1. Test your app: flutter run"
    echo "  2. Build Android: flutter build apk"
    echo "  3. Build iOS: flutter build ios (macOS only)"
}

### ---------- Main Execution ---------- ###
function main() {
    echo "🚀 Cross-Platform Flutter Project Setup"
    echo "========================================"

    detect_platform
    print_info "Detected platform: $PLATFORM"

    validate_prerequisites
    validate_flutter_project
    get_user_input
    validate_input

    echo ""
    print_info "Configuration Summary:"
    echo "  App Name: $APP_NAME"
    echo "  Package ID: $PACKAGE_ID"
    echo "  Platform: $PLATFORM"

    read -p "Continue with setup? (y/n): " -r CONFIRM
    if [[ ! $CONFIRM =~ ^[Yy]$ ]]; then
        print_info "Setup cancelled by user"
        exit 0
    fi

    create_backup
    extract_old_package_id
    rename_flutter_app
    reinit_git
    update_android_package
    move_android_package_structure
    update_ios_bundle_id
    flutter_cleanup
    success_message
}

# Execute main function
main "$@"