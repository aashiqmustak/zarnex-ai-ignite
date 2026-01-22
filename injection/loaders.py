from langchain_community.document_loaders import (
    PyPDFLoader,
    TextLoader,
    UnstructuredPowerPointLoader,
    UnstructuredWordDocumentLoader,
    WebBaseLoader
)

def load_documents(source: str, source_type: str):
    if source_type == "pdf":
        loader = PyPDFLoader(source)

    elif source_type == "txt":
        loader = TextLoader(source)

    elif source_type in ["ppt", "pptx"]:
        loader = UnstructuredPowerPointLoader(source)

    elif source_type in ["doc", "docx"]:
        loader = UnstructuredWordDocumentLoader(source)

    elif source_type == "url":
        loader = WebBaseLoader(source)

    else:
        raise ValueError(f"Unsupported source type: {source_type}")

    return loader.load()
