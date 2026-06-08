import React, {useRef, useState} from 'react';
import logo from './logo.svg';
import {Box, Button} from "@mui/material";
import './App.css';


function App() {

  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const onFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setSelectedFile(event.target.files?.[0] ?? null)
  };
  const fileInputRef = useRef<HTMLInputElement>(null);
  const handleJsonBody = async () => {
    const body = {
      source: "json",
      target: "xlsx",
      data: {
        "columns": ["id", "name", "age", "city", "score"],
        "rows": [
          [1, "Alice", 28, "New York", 94.5],
          [2, "Bob", 34, "Los Angeles", 82.1],
          [3, "Carol", 22, "Chicago", 77.8],
          [4, "David", 45, "Houston", 88.3],
          [5, "Eva", 30, "Phoenix", 91.0]
        ]
      }
    }
  
    const response = await fetch("http://localhost:5000/api/tabular", {
      method: "POST",
      headers: {"Content-Type": "application/json"},
      body: JSON.stringify(body)
    })

    const blob = await response.blob();
    const url = window.URL.createObjectURL(blob);
    const a =document.createElement("a");
    a.href = url
    a.download = "result.xlsx";
    a.click();
    window.URL.revokeObjectURL(url);
  }

  const handleJsonFile = async () => {
    //Use below code to combine file picker and immediate upload into one button
    //event: React.ChangeEvent<HTMLInputElement> PARAMETER
    //const file = event?.target.files?.[0];
    //if (!file) return;

    const formData = new FormData();
    formData.append("file", selectedFile!); //must be called file
    formData.append("source", "json");
    formData.append("target", "xlsx");
    const response = await fetch("http://localhost:5000/api/tabular", {
      method: "POST",
     // headers: {"Content-Type": "multipart/form-data"},
      body: formData,
    });
    if (!response.ok){
      throw new Error(`UUUpload failed: try again - ${response.status} - ${response.statusText}`)
    }
    const blob = await response.blob() //test without await
    const url = window.URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url
    a.download = "result.xlsx";
    a.click();
    window.URL.revokeObjectURL(url);

  }
//<button onClick={handleJsonFile}>Upload JSON File </button>
  return (
    <Box>
      <Button variant='contained' onClick={handleJsonBody}>Send Json Body</Button>
      <div>
        <input type="file" onChange={onFileChange} accept=".json"/>
        <button onClick={handleJsonFile}> Upload Json File</button>
      </div>
    </Box>
  )
  // return (
  //   <div className="App">
  //     <header className="App-header">
  //       <img src={logo} className="App-logo" alt="logo" />
  //       <p>
  //         Edit <code>src/App.tsx</code> and save to reload.
  //       </p>
  //       <a
  //         className="App-link"
  //         href="https://reactjs.org"
  //         target="_blank"
  //         rel="noopener noreferrer"
  //       >
  //         Learn React!!!!
  //       </a>
  //     </header>
  //   </div>
  // );
}


export default App;
