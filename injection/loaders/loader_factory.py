from .pdf_loader import load_pdf
from .txt_loader import load_txt

def load_content(file_path: str, file_type: str) -> str:
    if file_type == "pdf":
        return load_pdf(file_path)
    elif file_type == "txt":
        return load_txt(file_path)
    else:
        raise ValueError("Unsupported file type")
