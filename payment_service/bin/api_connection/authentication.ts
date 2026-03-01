import { load } from "jsr:@std/dotenv";
export async function Apivalidation() {
  const env = await load();
  const url = env["validation"]
  const consumer_key = env["consumer_key"];
  const consumer_secret = env["consumer_secret"];

  const credentials = btoa(`${consumer_key}:${consumer_secret}`)
  const response = await fetch(url, {
    method:"POST",
    headers:{
      "Authorization": `Basic ${credentials}`
    }
  }
)
  const data:Promise<JSON|null> = response.json()
  return data.access_token
}
export async function Customer2b(){

}
