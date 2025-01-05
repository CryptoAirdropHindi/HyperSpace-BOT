echo -e ""
echo -e ""
echo -e '\e[34m'
echo -e ' ██████╗██████╗ ██╗   ██╗██████╗ ████████╗ ██████╗  █████╗ ██╗██████╗ ██████╗ ██████╗  ██████╗ ██████╗ ██╗  ██╗██╗███╗   ██╗██████╗ ██╗'
echo -e '██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗██║██╔══██╗██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██║  ██║██║████╗  ██║██╔══██╗██║'
echo -e '██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   ██║   ██║███████║██║██████╔╝██║  ██║██████╔╝██║   ██║██████╔╝███████║██║██╔██╗ ██║██║  ██║██║'
echo -e '██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██║   ██║██╔══██║██║██╔══██╗██║  ██║██╔══██╗██║   ██║██╔═══╝ ██╔══██║██║██║╚██╗██║██║  ██║██║'
echo -e '╚██████╗██║  ██║   ██║   ██║        ██║   ╚██████╔╝██║  ██║██║██║  ██║██████╔╝██║  ██║╚██████╔╝██║     ██║  ██║██║██║ ╚████║██████╔╝██║'
echo -e ' ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝'
echo -e '\e[0m'
echo -e "                 \033[48;2;9;10;12m CryptoAirdropHindi \e[0m";
echo -e "\e[0;37m Subscribe Our Telegram Channel: \e[4;35mhttps://t.me/Crypto_airdropHM/";
echo -e "\e[0m"
echo -e ""
echo -e ""

sleep 5

#!/bin/bash

read -p "Enter screen name: " screen_name

if [[ -z "$screen_name" ]]; then
    echo "Screen name cannot be empty.."
    exit 1
fi

echo "Create a screen session with a name '$screen_name'..."
screen -S "$screen_name" -dm

echo "Running the 'aios-cli start' command inside a screen session '$screen_name'..."
screen -S "$screen_name" -X stuff "aios-cli start\n"

sleep 5

echo "Exit screen session '$screen_name'..."
screen -S "$screen_name" -X detach
sleep 5

if [[ $? -eq 0 ]]; then
    echo "Screen with name '$screen_name' was successfully created and ran the aios-cli start command.."
else
    echo "Failed to create screen."
    exit 1
fi

sleep 2

echo "Enter your private key (end with CTRL+D):"
cat > .pem

echo "Running the import-keys command with the .pem file..."
aios-cli hive import-keys ./.pem

sleep 5
echo "Menambahkan model dengan perintah aios-cli models add..."
model="hf:TheBloke/phi-2-GGUF:phi-2.Q4_K_M.gguf"

while true; do
    if aios-cli models add "$model"; then
        echo "Model berhasil ditambahkan dan proses download selesai!"
        break
    else
        echo "Terjadi kesalahan saat menambahkan model. Mengulang..."
        sleep 3  
    fi
done

echo "Menjalankan inferensi menggunakan model yang telah ditambahkan..."
infer_prompt="Hello, can you explain about the YouTube channel Share It Hub?"

while true; do
    if aios-cli infer --model "$model" --prompt "$infer_prompt"; then
        echo "Inferensi berhasil."
        break
    else
        echo "Terjadi kesalahan saat menjalankan inferensi. Mengulang..."
        sleep 3
    fi
done

echo "Menjalankan login dan select-tier..."
aios-cli hive login
aios-cli hive select-tier 5
aios-cli hive connect

sleep 5

echo "Menjalankan Hive inferensi menggunakan model yang telah ditambahkan..."
infer_prompt="Hello, can you explain about the YouTube channel Share It Hub?"

while true; do
    if aios-cli hive infer --model "$model" --prompt "$infer_prompt"; then
        echo "Hive Inferensi berhasil."
        break
    else
        echo "Terjadi kesalahan saat menjalankan inferensi. Mengulang..."
        sleep 3
    fi
done
echo "Menghentikan proses 'aios-cli start' dengan 'aios-cli kill'..."
aios-cli kill

echo "Masuk kembali ke screen '$screen_name' untuk menjalankan aios-cli start --connect..."

screen -S "$screen_name" -X stuff "echo 'Menunggu 5 detik sebelum menjalankan perintah...'; aios-cli start --connect\n"

echo "Proses selesai. aios-cli start --connect telah dijalankan di dalam screen dan sistem telah kembali ke latar belakang."
