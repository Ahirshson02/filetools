import io
import tempfile
from pathlib import Path
from pdf2docx import Converter

def pdf_to_docx(data) -> io.BytesIO:
    print("running pdf_to_docx Server side")
    # data is a Flask FileStorage object
    pdf_bytes = data.read()

    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir_path = Path(tmpdir)
        input_path = tmpdir_path / "input.pdf"
        output_path = tmpdir_path / "output.docx"

        input_path.write_bytes(pdf_bytes)


#look into pdfplumber to maintain all the special formatting
        cv = Converter(str(input_path)) #can skip above and do Converter(pdf_bytes)
        cv.convert(str(output_path))
        cv.close()

        result = io.BytesIO(output_path.read_bytes())

    result.seek(0)
    return result