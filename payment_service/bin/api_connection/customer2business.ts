import {load} from "jsr:@std/dotenv"

 export async function Customertobusiness(){
	const env = await load();

	const response = await fetch(url,{
		method:"POST",
		headers:{
			"Content-Type": "application/json",
			"Authorization": `Bearer ${}`
		}
	})
	const data = response.json()
	
}
