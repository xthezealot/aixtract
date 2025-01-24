# aixtract 🚀

**Flatten directory structures for AI analysis while preserving hierarchy context**

## Description

`aixtract` transforms nested file structures into flat directories with encoded path information, making it ideal for uploading codebases to AI assistants that lack directory support.

**How it works**:

- Reads file paths from `.aixtract` configuration
- Copies files to a new timestamped temporary directory
- Encodes original paths using double underscores (`__`)

**Example transformation**:  
`src/models/user.py` → `src__models__user.py`

## Why Use This?

- 🤖 **AI-Friendly**: Maintain file relationships for LLMs without directory support
- 🕵️ **Context Preservation**: Hierarchical information remains visible in filenames
- ⚡ **Zero Dependencies**: Single binary for macOS/Linux

## Installation 📦

### Precompiled Binaries

```bash
# Ensure target directory exists
mkdir -p ~/.local/bin

# macOS (Apple Silicon)
curl -L https://github.com/xthezealot/aixtract/releases/download/v1.0.0/aixtract-darwin-arm64 -o ~/.local/bin/aixtract && chmod +x ~/.local/bin/aixtract

# Linux (AMD64)
wget https://github.com/xthezealot/aixtract/releases/download/v1.0.0/aixtract-linux-amd64 -O ~/.local/bin/aixtract && chmod +x ~/.local/bin/aixtract

# Linux (ARM64)
wget https://github.com/xthezealot/aixtract/releases/download/v1.0.0/aixtract-linux-arm64 -O ~/.local/bin/aixtract && chmod +x ~/.local/bin/aixtract
```

**Add to PATH** (if not already):

```bash
export PATH="$HOME/.local/bin:$PATH"
```

## Usage ⚒

### Basic Workflow

1. **Create Configuration File**  
   Create `.aixtract` in your project root with target files:

   ```bash
   # Example .aixtract file
   src/models/user.py
   tests/test_user.py
   config/settings.json

   # Use find to auto-generate (e.g., all Python files)
   # find . -name "*.py" >> .aixtract
   ```

2. **Run Extraction**  
   From your project directory:

   ```bash
   aixtract
   ```

3. **Access Output**  
   Files are copied to:  
   `~/Downloads/<project_name>_<timestamp>/`  
   (Automatically opened on macOS/Linux)

### Advanced Options

```bash
# Custom output directory
aixtract --output ~/my_custom_dir

# Custom configuration file
aixtract --config my_special_list.txt
```

## Example Transformation 🌟

**Original Structure**:

```text
myproject/
├── .aixtract
├── src/
│   └── models/
│       └── user.py
├── tests/
│   └── test_user.py
└── config/
    └── settings.json
```

**After Processing**:

```text
/tmp/myproject_20250101_123456/
├── src__models__user.py
├── tests__test_user.py
└── config__settings.json
```

## Requirements ☑️

- **OS**: macOS 10.15+ or modern Linux distro
- **Arch**: x86_64 or ARM64
- **Permissions**: Read access to source files, write access to output directory

## FAQ ❓

**Q**: Can I use this for non-code files?  
**A**: Absolutely! Works with any file type
